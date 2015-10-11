//
//  KGIntroVC.m
//  agrBankWallet
//
//  Created by Neely on 15/10/1.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGIntroVC.h"
#import "KGIntroDetailVC.h"
#import "KGIntroCell.h"
#import "UIImageView+WebCache.h"

@interface KGIntroVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation KGIntroVC

- (instancetype)init{
    
    if (self = [super init]) {
        
//        self.dataSource = @[@"1",@"2",@"3",@"4",@"5",@"6"].mutableCopy;
        self.dataSource = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"介绍";
    [self.view addSubview:self.tableView];
    
    AVQuery *query = [[AVQuery alloc] initWithClassName:@"IntroClass"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if(!error){
            
            for (AVObject *obj  in objects) {
                
                [self.dataSource addObject:obj];
            }
            
            [self.tableView reloadData];
        }
    }];
    
    
    

    
}


#pragma mark - getter ---- 
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 64,self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];

    }
    return _tableView;
}


#pragma mark -  tableView dataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AVObject *obj = [self.dataSource objectAtIndex:indexPath.row];
    NSString *cellStyle = obj[@"introCellType"];
    if ([cellStyle isEqualToString:@"1"]) {
        
        return KFullHeight;
    }
    return KHalfHeight;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdent = @"introCell";
    KGIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (!cell) {
        
        cell = [[KGIntroCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdent];
    }
    
    AVObject *obj = [self.dataSource objectAtIndex:indexPath.row];
    
    NSString *cellStyle = obj[@"introCellType"];
    NSString *imageUrl = obj[@"introImageUrl"];
    cell.aTitleLabel.text = obj[@"introName"];
    [cell.aImageView  sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    cell.aStyle = (CellStyle)[cellStyle integerValue];
//    if (indexPath.row %2 == 1) {
//        cell.backgroundColor = [UIColor blueColor];
//
//    }
    return cell;
}


#pragma mark -- tablview delegate--
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"%zd",indexPath.row);
    
    AVObject *obj = [self.dataSource objectAtIndex:indexPath.row];
    NSString *urlStr = obj[@"introDetailUrl"];
    KGIntroDetailVC *detailVC = [[KGIntroDetailVC alloc] init];
    detailVC.urlString = urlStr;
    detailVC.navigationItem.title = obj[@"introName"];
    [detailVC setHidesBottomBarWhenPushed:YES];
    detailVC.introId = obj.objectId;
    [self.navigationController pushViewController:detailVC animated:YES];
    
//    UIImage *image = [UIImage imageNamed:@"gaosibeijing@2x"];
//    NSData *data = UIImageJPEGRepresentation(image, 0.8);
//    AVFile *file = [AVFile fileWithData:data];
//    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        NSLog(@"%zd --- %@",succeeded,file);
//        
//    }];
    
    
//    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//        
//    }];
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
