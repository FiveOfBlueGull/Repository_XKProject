//
//  KGUserCenterVC.h
//  agrBankWallet
//
//  Created by lianzhandong on 15/9/23.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGCommonBaseVC.h"

@interface KGUserCenterVC : KGCommonBaseVC

@property (nonatomic, weak)IBOutlet UITableView *tableView;

@property (nonatomic, weak)IBOutlet UILabel     *userNameLbl;
@property (nonatomic, weak)IBOutlet UILabel     *userAccountLbl;

@end
