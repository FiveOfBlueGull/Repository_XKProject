//
//  KGVoucherListCell.h
//  agrBankWallet
//
//  Created by lianzhandong on 15/10/2.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>

@interface KGVoucherListCell : UITableViewCell

@property (nonatomic, strong)IBOutlet UIImageView *bgImageView;

@property (nonatomic, strong)IBOutlet UIImageView *leftImageView;

@property (nonatomic, strong)IBOutlet UILabel     *activityNameLbl;

@property (nonatomic, strong)IBOutlet UILabel     *shopNameLbl;


- (void)fillWithVoucher:(AVObject *)voucher activity:(AVObject *)activity shop:(AVObject *)shop;

@end
