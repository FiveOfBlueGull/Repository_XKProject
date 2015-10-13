//
//  KGExchangeGiftVC.m
//  agrBankWallet
//
//  Created by lianzhandong on 15/10/12.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGExchangeGiftVC.h"
#import "KGGiftListCell.h"

@interface KGExchangeGiftVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *giftListArray;
@property (nonatomic, strong)NSMutableDictionary *giftDictionary;


@end

@implementation KGExchangeGiftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的礼品";
    [self.rootTabBarVC setTabBarHidden:YES animated:YES];
    self.giftListArray = [[NSMutableArray alloc] init];
    self.giftDictionary = [[NSMutableDictionary alloc] init];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getGiftList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)goBack{
    if ([[[self.navigationController viewControllers] firstObject] isKindOfClass:[self class]]) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.rootTabBarVC setTabBarHidden:NO animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
}



#pragma mark --
- (void)getGiftList{
    AVQuery *query = [AVQuery queryWithClassName:@"UserGiftListClass"];
    [query whereKey:@"userInfoID" equalTo:self.globalDataModel.userObjectID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [self.giftListArray removeAllObjects];
            [self.giftListArray addObjectsFromArray:objects];
            AVQuery *giftQuery = [AVQuery queryWithClassName:@"GiftClass"];
            [giftQuery whereKey:@"objectId" matchesKey:@"giftInfoID" inQuery:query];
            [giftQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    [self.giftDictionary removeAllObjects];
                    for (AVObject *object in objects) {
                        [self.giftDictionary setObject:object forKey:object[@"objectId"]];
                    }
                    [self.tableView reloadData];
                }else{
                    NSLog(@"获取礼品信息失败！");
                }
            }];
        }else{
            NSLog(@"获取礼品列表失败！");
        }
    }];
}
#pragma mark --
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.giftListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGGiftListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGGiftListCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KGGiftListCell" owner:self options:nil] firstObject];
    }
    AVObject *object = [self.giftListArray objectAtIndex:indexPath.row];
    [cell fillCellWithObject:[self.giftDictionary objectForKey:object[@"giftInfoID"]]];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
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
