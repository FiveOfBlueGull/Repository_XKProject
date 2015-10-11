//
//  KGSubmitVC.m
//  agrBankWallet
//
//  Created by Neely on 15/10/11.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//



#import "KGSubmitVC.h"
#import "KGInputVC.h"
#import "FormModel.h"

#define PCellTitle @"title"
#define PcellDesc @"desc"


@interface KGSubmitVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) NSDictionary *titleDic;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) FormModel *formModel;

@end

@implementation KGSubmitVC


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        
        self.titleDic = @{@"0":@"预约存款",
                          @"1":@"预约取款",
                          @"2":@"预约咨询",
                          @"3":@"预约咨询"
                          };
        self.dataSource = [NSMutableArray array];
        self.formModel = [[FormModel alloc] init];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = [self.titleDic objectForKey:[NSString stringWithFormat:@"%zd",(NSInteger)self.type]];
    [self.rootTabBarVC setTabBarHidden:YES animated:YES];
    [self.view addSubview:self.tableView];
    [self _setRightBarItem];
    
}

- (void)goBack{
    
    [self.rootTabBarVC setTabBarHidden:NO animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self _loadDataSource];
    [self.tableView reloadData];
}

#pragma mark - getter - 
- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 64,self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    }
    return _tableView;
}



#pragma mark - private - 
- (void)_loadDataSource{
    
//   self.formModel.aAddress
    [self.dataSource removeAllObjects];
    NSDictionary *dic1 = @{PCellTitle:@"姓名",PcellDesc:self.formModel.aName};
    NSDictionary *dic2 = @{PCellTitle:@"电话",PcellDesc:self.formModel.aPhoneNum};
    NSDictionary *dic3 = @{PCellTitle:@"证件号码",PcellDesc:self.formModel.aIdCard};
    NSDictionary *dic4 = @{PCellTitle:@"地址",PcellDesc:self.formModel.aAddress};
    NSArray *array1 = @[dic1,dic2,dic3,dic4];
    [self.dataSource addObject:array1];
    
//    NSDictionary *dic1 = @{PCellTitle:@"姓名",PcellDesc:@""};
//    NSDictionary *dic1 = @{PCellTitle:@"姓名",PcellDesc:@""};
//    NSDictionary *dic1 = @{PCellTitle:@"姓名",PcellDesc:@""};
    
}


- (void)_setRightBarItem{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - action - 
- (void)rightAction:(UIBarButtonItem *)sender{
    

    if (self.formModel.aName.length == 0 || self.formModel.aPhoneNum.length == 0 || self.formModel.aIdCard.length == 0 || self.formModel.aAddress.length == 0) {
        
        NSString *message = @"请完善信息";
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertV show];
        return ;
    }
    
    

    AVObject *obj = [[AVObject alloc] initWithClassName:@"FormClass"];
    
    [obj setObject:self.globalDataModel.userPhone forKey:@"FormUserID"];
    [obj setObject:self.formModel.aName forKey:@"FormUserName"];
    [obj setObject:self.formModel.aPhoneNum forKey:@"FormUserPhone"];
    [obj setObject:self.formModel.aIdCard forKey:@"FormUserIDCard"];
    [obj setObject:self.formModel.aAddress forKey:@"FormUserAddress"];
    [obj setObject:[NSString stringWithFormat:@"%zd",self.type] forKey:@"FormType"];
    
    [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            
            NSString *message = @"提交成功";
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertV show];

        }else{
            NSString *message = @"提交失败，请稍后再试";
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertV show];
            
        }
    }];
//    NSLog(@"提交");
}


#pragma mark - tableView dataSource - 
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 10;
    }
    return 20;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
  return  [[self.dataSource objectAtIndex:section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdent = [NSString stringWithFormat:@"%zd_%zd",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdent];
    }
    
    NSDictionary *dic = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:PCellTitle];
    cell.detailTextLabel.text = [dic objectForKey:PcellDesc];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - tableView delegate -
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KGInputVC *inputVC = [[KGInputVC alloc] init];
    NSDictionary *dic = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    inputVC.navigationItem.title  = [dic objectForKey:PCellTitle];
    inputVC.placeHolder = [NSString stringWithFormat:@"请输入%@",[dic objectForKey:PCellTitle]];
    
    __weak typeof(self) weakSelf = self;
    inputVC.callBack = ^(NSString *string){
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            weakSelf.formModel.aName = string;
        }
        if (indexPath.section == 0 && indexPath.row == 1) {
            weakSelf.formModel.aPhoneNum = string;
        }
        if (indexPath.section == 0 && indexPath.row == 2) {
            weakSelf.formModel.aIdCard = string;
        }

        if (indexPath.section == 0 && indexPath.row == 3) {
            weakSelf.formModel.aAddress = string;
        }

    };
    
    
    [self.navigationController pushViewController:inputVC animated:YES];
}


#pragma mark - alertView delegate - 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [self.navigationController popViewControllerAnimated:YES];
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
