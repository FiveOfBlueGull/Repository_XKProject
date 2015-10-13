//
//  KGLuckyDrawGiftVC.m
//  agrBankWallet
//
//  Created by lianzhandong on 15/10/12.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGLuckyDrawGiftVC.h"
#import "KGLuckyGiftListCell.h"
#import "KGExchangeGiftVC.h"
#import "KGCommonBaseNVC.h"

@interface KGLuckyDrawGiftVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign)NSInteger       currentTag;
@property (nonatomic, strong)NSTimer        *timer;

@property (nonatomic, assign)NSTimeInterval  duration;

@property (nonatomic, strong)NSMutableArray *giftListArray;

@end

@implementation KGLuckyDrawGiftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"积分抽奖";
    [self.rootTabBarVC setTabBarHidden:YES animated:YES];
    self.currentTag = 1000;
    self.duration = 0.5;
    self.giftListArray = [[NSMutableArray alloc] init];
    [self getGiftList];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"🎁" style:UIBarButtonItemStylePlain target:self action:@selector(showGiftList)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack{
    [self.rootTabBarVC setTabBarHidden:NO animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 
static NSInteger resultTag = 1000;
static NSInteger circle = 0;
- (void)showGiftList{
    KGExchangeGiftVC *vc = [[KGExchangeGiftVC alloc] initWithNibName:@"KGExchangeGiftVC" bundle:nil customBackButton:YES];
    KGCommonBaseNVC *nvc = [[KGCommonBaseNVC alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void)getLuckyGift:(UIButton *)sender{
    [self getUserAccountRemain];
//    [self prepareForAnimation];
}

- (void)prepareForAnimation{
    resultTag = arc4random() % 10 + 1000;
    NSLog(@"%@",[@(resultTag) description]);
    if (resultTag - self.currentTag >= 0) {
        circle = 10 * 5 + (resultTag - self.currentTag);
    }else{
        circle = 10 * 6 + (resultTag - self.currentTag);
    }
    self.duration = 0.5;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(animation) userInfo:nil repeats:NO];
    self.getGiftBtn.userInteractionEnabled = NO;
}

- (void)animation{
    
    NSInteger tag = (self.currentTag + 1) > 1009 ? 1000 : (self.currentTag + 1);
    UILabel *lbl = (UILabel *)[self.luckyView viewWithTag:self.currentTag];
    lbl.backgroundColor = [UIColor colorWithRed:184 / 255.0f green:184 / 255.0f blue:184 / 255.0f alpha:1.0f];
    lbl = (UILabel *)[self.luckyView viewWithTag:tag];
    lbl.backgroundColor = [UIColor colorWithRed:239 / 255.0f green:168 / 255.0f blue:189 / 255.0f alpha:1.0f];
    self.currentTag = tag;
    circle --;
    NSLog(@"%@",[@(circle) description]);
    if (circle == 0) {
        self.timer = nil;
        self.getGiftBtn.userInteractionEnabled = YES;
        [self didFinishAnimationWithTag:resultTag];
    }else{
        if (self.duration > 0.2) {
            self.duration -= 0.025;
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.duration target:self selector:@selector(animation) userInfo:nil repeats:NO];
    }
}
//01 03 05 08 09
- (void)didFinishAnimationWithTag:(NSInteger)tag{
    UILabel *lbl = (UILabel *)[self.luckyView viewWithTag:tag];
    if (tag == 1001) {
        [self alertWithMessage:[NSString stringWithFormat:@"恭喜您中了%@!",lbl.text] delay:0.5];
        [self userDidGetGiftWithType:1];
    }else if (tag == 1003){
        [self alertWithMessage:[NSString stringWithFormat:@"恭喜您中了%@!",lbl.text] delay:0.5];
        [self userDidGetGiftWithType:2];
    }else if (tag == 1005){
        [self alertWithMessage:[NSString stringWithFormat:@"恭喜您中了%@!",lbl.text] delay:0.5];
        [self userDidGetGiftWithType:3];
    }else if (tag == 1008){
        [self alertWithMessage:[NSString stringWithFormat:@"恭喜您中了%@!",lbl.text] delay:0.5];
        [self userDidGetGiftWithType:4];
    }else if (tag == 1009){
        [self alertWithMessage:[NSString stringWithFormat:@"恭喜您中了%@!",lbl.text] delay:0.5];
        [self userDidGetGiftWithType:5];
    }else{
        [self alertWithMessage:@"您没有中奖,再接再厉哦！" delay:0.5];
    }
}

#pragma mark -- request

- (void)userDidGetGiftWithType:(NSInteger)type{
    NSString *objectId = @"";
    for (AVObject *object in self.giftListArray) {
        if ([object[@"giftType"] integerValue] == type) {
            objectId = object[@"objectId"];
        }
    }
    AVObject *object = [AVObject objectWithClassName:@"UserGiftListClass"];
    [object setObject:objectId forKey:@"giftInfoID"];
    [object setObject:self.globalDataModel.userObjectID forKey:@"userInfoID"];
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self alertWithMessage:@"领取礼品成功!"];
        }else{
            [self alertWithMessage:@"领取礼品失败!"];
        }
    }];
}
- (void)userDidGetGiftWithObject:(AVObject *)object{
    NSString *giftId = object[@"objectId"];
    AVObject *listOne = [AVObject objectWithClassName:@"UserGiftListClass"];
    [listOne setObject:giftId forKey:@"giftInfoID"];
    [listOne setObject:self.globalDataModel.userObjectID forKey:@"userInfoID"];
    [listOne saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self alertWithMessage:@"领取礼品成功!"];
        }else{
            [self alertWithMessage:@"领取礼品失败!"];
        }
    }];
}

- (void)getUserAccountRemain{
    __weak typeof(self) weakself = self;
    AVQuery *query = [[AVQuery alloc] initWithClassName:@"UserClass"];
    [query whereKey:@"objectId" equalTo:self.globalDataModel.userObjectID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error && [objects count] > 0) {
            AVObject *user = [objects firstObject];
            NSNumber *accountUserHas = user[@"userAccount"];
            if ([accountUserHas integerValue] < 100) {
                [self alertWithMessage:@"积分不满100,无法抽奖!"];
            }else{
                accountUserHas = [NSNumber numberWithInt:(int)([accountUserHas integerValue] - 100)];
                [user setObject:[accountUserHas description] forKey:@"userAccount"];
                [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        NSLog(@"扣除积分成功!");
                        [weakself prepareForAnimation];
                    }else{
                        [self alertWithMessage:@"扣除积分失败,您不能抽奖!"];
                    }
                }];
            }
        }else{
            [self alertWithMessage:@"无法获取您的积分信息!"];
        }
    }];

}

- (void)getGiftList{
    AVQuery *query = [AVQuery queryWithClassName:@"GiftClass"];
    [query orderByAscending:@"giftType"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self.giftListArray addObjectsFromArray:objects];
        [self.tableView reloadData];
    }];
}

- (void)exchangeGiftWithObject:(AVObject *)object{
    NSInteger cost = [object[@"accountCost"] integerValue];
    [self.globalDataModel compareUserAccoutRemainWithCost:cost
                                      moreOrEqualThanCost:^{
                                          [self.globalDataModel reduceUserAccountWithCost:cost
                                                                                  success:^{
                                                                                      [self userDidGetGiftWithObject:object];
                                                                                  } reduceFailure:^{
                                                                                      [self alertWithMessage:@"扣除积分失败,您未能领取到该礼品!"];
                                                                                  } requestFailure:^{
                                                                                      [self alertWithMessage:@"扣除积分失败,您未能领取到该礼品!"];
                                                                                  }];
                                      } lessThanCost:^{
                                          [self alertWithMessage:@"您的积分不足,还是看看其他礼品吧!"];
                                      } requestFailure:^{
                                          [self alertWithMessage:@"无法获取您的积分信息!"];
                                      }];
}

#pragma mark -- delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.giftListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KGLuckyGiftListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KGLuckyGiftListCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KGLuckyGiftListCell" owner:nil options:nil] firstObject];
    }
    [cell fillWithObject:[self.giftListArray objectAtIndex:indexPath.row] index:indexPath.row];
    __weak typeof(self) weakself = self;
    cell.didClickExchangeBtn = ^(NSInteger index){
        [weakself exchangeGiftWithObject:[weakself.giftListArray objectAtIndex:index]];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 71.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"奖品列表";
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
