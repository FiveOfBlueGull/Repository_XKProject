//
//  KGVoucherListVC.m
//  agrBankWallet
//
//  Created by lianzhandong on 15/10/2.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGVoucherListVC.h"
#import "KGVoucherDetailVC.h"
#import "KGVoucherListCell.h"

@interface KGVoucherListVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *dataSourceArray;
@property (nonatomic, strong)NSMutableDictionary *activityDic;
@property (nonatomic, strong)NSMutableDictionary *shopDic;

@property (nonatomic, strong)NSNumber            *reloadSign;

@end

@implementation KGVoucherListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的优惠券";
    [self.rootTabBarVC setTabBarHidden:YES animated:YES];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.reloadSign = [NSNumber numberWithInt:0];
    [self.reloadSign addObserver:self forKeyPath:@"intValue" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self getVoucherList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack{
    [self.rootTabBarVC setTabBarHidden:NO animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- get/set

- (NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}

- (NSMutableDictionary *)activityDic{
    if (!_activityDic) {
        _activityDic = [NSMutableDictionary dictionary];
    }
    return _activityDic;
}

- (NSMutableDictionary *)shopDic{
    if (!_shopDic) {
        _shopDic = [NSMutableDictionary dictionary];
    }
    return _shopDic;
}

- (void)setReloadSign:(NSNumber *)reloadSign{
    if (_reloadSign != reloadSign) {
        _reloadSign = reloadSign;
        if ([reloadSign integerValue] == 3) {
            [self toReloadData];
        }
    }
}

#pragma mark -- AVObject

- (void)getVoucherList{
    AVQuery *listQuery = [AVQuery queryWithClassName:@"VoucherListClass"];
    [listQuery whereKey:@"userInfoID" equalTo:[self.globalDataModel.userObjectID description]];
    [listQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [self.dataSourceArray addObjectsFromArray:objects];
            self.reloadSign = [NSNumber numberWithInt:1];
            AVQuery *activityListQuery = [AVQuery queryWithClassName:@"ActivityClass"];
            [activityListQuery whereKey:@"objectId" matchesKey:@"activityInfoID" inQuery:listQuery];
            [activityListQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if(!error){
                    for (AVObject *object in objects) {
                        [self.activityDic setObject:object forKey:object[@"objectId"]];
                    }
                }else{
                    NSLog(@"获取活动详情失败！");
                }
                self.reloadSign = [NSNumber numberWithInt:(int)([self.reloadSign integerValue] + 1)];
            }];
            
            AVQuery *shopListQuery = [AVQuery queryWithClassName:@"ShopClass"];
            [shopListQuery whereKey:@"objectId" matchesKey:@"shopInfoID" inQuery:listQuery];
            [shopListQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    for (AVObject *object in objects) {
                        [self.shopDic setObject:object forKey:object[@"objectId"]];
                    }
                }else{
                    NSLog(@"获取店铺详情失败！");
                }
                self.reloadSign = [NSNumber numberWithInt:(int)([self.reloadSign integerValue] + 1)];
            }];
        }else{
            NSLog(@"获取优惠券详情失败！");
        }
    }];
}

#pragma mark -- datasource --


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 69.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGVoucherListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGVoucherListCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KGVoucherListCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    AVObject *voucher = [self.dataSourceArray objectAtIndex:indexPath.row];
    AVObject *acticity = [self.activityDic objectForKey:voucher[@"activityInfoID"]];
    AVObject *shop = [self.shopDic objectForKey:voucher[@"shopInfoID"]];
    [cell fillWithVoucher:voucher activity:acticity shop:shop];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KGVoucherDetailVC *vc = [[KGVoucherDetailVC alloc] initWithNibName:@"KGVoucherDetailVC" bundle:nil customBackButton:YES];
    AVObject *voucher = [self.dataSourceArray objectAtIndex:indexPath.row];
    AVObject *acticity = [self.activityDic objectForKey:voucher[@"activityInfoID"]];
    AVObject *shop = [self.shopDic objectForKey:voucher[@"shopInfoID"]];
    vc.voucher = voucher;
    vc.shop = shop;
    vc.activity = acticity;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- private 

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"intValue"] && [object integerValue] == 3) {
        [self.tableView reloadData];
    }
}

- (void)toReloadData{
    [self.tableView reloadData];
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
