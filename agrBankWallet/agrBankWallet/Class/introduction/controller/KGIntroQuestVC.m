//
//  KGIntroQuestVC.m
//  agrBankWallet
//
//  Created by Neely on 15/10/4.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGIntroQuestVC.h"
#import "KGIntroQACell.h"
#import "KGCommonBaseNVC.h"
#import "KGLoginVC.h"

#define KAlertTag1 1234
#define KAlertTag2 1235

#define KAddAccountScore 100


@interface KGIntroQuestVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) KGIntroQACell *selectCell;

@end

@implementation KGIntroQuestVC

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.dataSource = [NSMutableArray array];
    }
    return self;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"答题赢积分";
    [self _setRightBarItem];
    [self.view addSubview:self.tableView];
    [self _loadDataSource];
   

    
}

#pragma mark - getter ----
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 64,self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}



#pragma mark - private fun - 
- (void)_setRightBarItem{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitAction:)];
    item.tintColor = [UIColor blueColor];
    self.navigationItem.rightBarButtonItem = item;
}


- (CGFloat )_heightWithFontSize:(CGFloat )fontSize string:(NSString *)string{
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake( ScreenWidth - 20, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:NULL];
    return rect.size.height;
    
}


#pragma mark - Action -
- (void)submitAction:(UIBarButtonItem *)sender{
    
    NSLog(@"提交 － ");
    
    if (![self.globalDataModel isLogin]) {
        KGLoginVC *vc = [[KGLoginVC alloc] initWithNibName:@"KGLoginVC" bundle:nil];
        KGCommonBaseNVC *nvc = [[KGCommonBaseNVC alloc] initWithRootViewController:vc];
        [self.navigationController presentViewController:nvc animated:YES completion:^{
            
        }];
        
        return ;
    }


    
    if (!self.selectCell) {
        
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择一个答案" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertV show];
        
        return ;
    }
    AVObject *questObj = [self.dataSource objectAtIndex:0];
    AVObject *answerObj = [self.dataSource objectAtIndex:self.selectCell.indexPath.row];
    
    NSString *sureAnswer = questObj[@"introA"];
    NSString *selectAnswer = answerObj[@"introACode"];
    if ([sureAnswer isEqualToString:selectAnswer]) {
        
        self.globalDataModel.userAccount = [NSString stringWithFormat:@"%zd",[self.globalDataModel.userAccount integerValue] + KAddAccountScore];
     
        
        AVQuery *query = [[AVQuery alloc] initWithClassName:@"UserClass"];
        [query whereKey:@"userPhone" equalTo:self.globalDataModel.userPhone];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            if (!error && objects.count > 0) {
                AVObject *obj = [objects firstObject];
                [obj setObject:self.globalDataModel.userAccount forKey:@"userAccount"];
                [obj saveInBackground];            }
        }];

        NSString *message = [NSString stringWithFormat:@"恭喜你答对了，获得%zd积分",KAddAccountScore];
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        alertV.tag = KAlertTag1;
        [alertV show];

    }else{
        
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不好意思，您错了，还有一次机会哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertV show];

    }
    
}

#pragma mark - tableView dataSource - 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AVObject *obj = [self.dataSource objectAtIndex:indexPath.row];

    if (indexPath.row == 0) {
      
        NSString *string =  obj[@"introQ"];
        
        return [self _heightWithFontSize:17 string:string] + 20;
    }
    
    NSString *string =  obj[@"introAName"];
    return [self _heightWithFontSize:14 string:string] + 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdent = @"QACell";
    KGIntroQACell  *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (!cell) {
        
        cell = [[KGIntroQACell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdent];
    }
    
    cell.aHeight = [tableView rectForRowAtIndexPath:indexPath].size.height;
    cell.aIsSelect = NO;
    cell.indexPath = indexPath;
    AVObject *obj = [self.dataSource objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.row == 0) {
        cell.aTitleLabel.text = obj[@"introQ"];
        cell.aType = CellTypeQuest;
        
    }else{
        cell.aTitleLabel.text = obj[@"introAName"];
        cell.aType = CellTypeAnswer;
        cell.textLabel.highlightedTextColor = [UIColor orangeColor];
    }
    return cell;

}


#pragma mark - tableView delegate - 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return ;
    }
    
    KGIntroQACell *cell =(KGIntroQACell *) [tableView cellForRowAtIndexPath:indexPath];
    
    self.selectCell.aIsSelect = NO;
    self.selectCell = cell;
    self.selectCell.aIsSelect = YES;

    
}


#pragma mark - alertView delegate - 
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0 && (alertView.tag == KAlertTag1 || alertView.tag == KAlertTag2)) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - loadDAtaSource - 

- (void)_loadDataSource{
    
    
    AVQuery *query = [[AVQuery alloc] initWithClassName:@"IntroQuestClass"];
    [query whereKey:@"introID" equalTo:self.introId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if(!error && objects.count != 0){
            [self.dataSource removeAllObjects];

            AVObject *obj  = [objects firstObject];
            NSString *questId = obj.objectId;
            
            [self.dataSource addObject:obj];
            
            AVQuery *tempQuery = [[AVQuery alloc] initWithClassName:@"IntroAnswerOptionClass"];
            [tempQuery whereKey:@"introQID" equalTo:questId];
            [tempQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                
                if (!error) {
                    
                    objects = [objects sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                        
                        NSString *code1 = obj1[@"introACode"];
                        NSString *code2 = obj2[@"introACode"];
                        if ([code1 compare:code2] >= 0) {
                            
                            return NSOrderedDescending;
                        }
                        return NSOrderedAscending;

                        
                    }];
                    
                    for (AVObject *tempObj in objects) {
                        
                        [self.dataSource addObject:tempObj];
                    }
                    
                    
                    [self.tableView reloadData];
                }
            }];
            
            
        }else{
            
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不好意思，暂时还没有答题赢积分活动，谢谢您的关注" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            alertV.tag = KAlertTag2;
            [alertV show];
            
        }

    }];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
