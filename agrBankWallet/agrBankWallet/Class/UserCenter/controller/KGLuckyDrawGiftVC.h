//
//  KGLuckyDrawGiftVC.h
//  agrBankWallet
//
//  Created by lianzhandong on 15/10/12.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGCommonBaseVC.h"

@interface KGLuckyDrawGiftVC : KGCommonBaseVC

@property (nonatomic, weak)IBOutlet UIView *luckyView;

@property (nonatomic, weak)IBOutlet UIButton *getGiftBtn;

@property (nonatomic, weak)IBOutlet UITableView *tableView;

- (IBAction)getLuckyGift:(UIButton *)sender;


@end
