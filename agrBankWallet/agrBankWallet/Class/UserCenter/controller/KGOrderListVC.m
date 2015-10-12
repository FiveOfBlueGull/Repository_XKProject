//
//  KGOrderListVC.m
//  agrBankWallet
//
//  Created by lianzhandong on 15/9/27.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGOrderListVC.h"
#import "KGSubmitVC.h"
#import "FormQord.h"

@interface KGOrderListVC ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) NSDictionary *cellTitleDic;
@property (nonatomic,strong) UITableView *aTableView;

@end

@implementation KGOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray array];
    self.cellTitleDic = @{@"0":@"预约存款",
                          @"1":@"预约取款",
                          @"2":@"预约咨询"
                          };
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的预约";
    [self.rootTabBarVC setTabBarHidden:YES animated:YES];
    
    self.tableView.alpha = 0;
    [self.view addSubview:self.aTableView];
    [self _loadDadaSource];
}


- (void)_loadDadaSource{
    
    
    AVQuery *query = [[AVQuery alloc] initWithClassName:@"FormClass"];
    [query whereKey:@"FormUserID" equalTo:self.globalDataModel.userPhone];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if(!error){
            
            for (AVObject *obj  in objects) {
                
                [self.dataSource addObject:obj];
            }
            
            [self.aTableView reloadData];
        }
    }];

    
}
    
#pragma mark - getter -
- (UITableView *)aTableView{
    
    
    if (!_aTableView) {
        _aTableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 64,ScreenWidth, self.view.frame.size.height) style:UITableViewStylePlain];
        _aTableView.delegate = self;
        _aTableView.dataSource = self;
        _aTableView.tableFooterView = [[UIView alloc] init];
        _aTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _aTableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        
    }
    return _aTableView;

}


#pragma mark -- tableView dataSource - 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *cellIden = @"FormCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIden];
    }
    
    AVObject *obj = self.dataSource[indexPath.row];
    NSString *type = obj[@"FormType"];

    cell.textLabel.text = self.cellTitleDic[type];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd hh:mm"];
    NSString *dateStr = [formatter stringFromDate:obj.createdAt];
    
    cell.detailTextLabel.text = dateStr;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AVObject *obj = self.dataSource[indexPath.row];
    
    NSString *url = [obj objectForKey:@"FormQRUrl"];
    
    FormQord *qordVC = [[FormQord alloc] init];
    qordVC.qrUrl = url;
    [self.navigationController pushViewController:qordVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack{
    [self.rootTabBarVC setTabBarHidden:NO animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
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
