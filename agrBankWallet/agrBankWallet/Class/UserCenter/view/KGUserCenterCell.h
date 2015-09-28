//
//  KGUserCenterCell.h
//  agrBankWallet
//
//  Created by lianzhandong on 15/9/24.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGUserCenterCell : UITableViewCell

@property (nonatomic, weak)IBOutlet UIImageView *leftImageView;

@property (nonatomic, weak)IBOutlet UILabel     *titleLbl;

@property (nonatomic, weak)IBOutlet UIImageView *righImageView;

- (void)fillCellWithObject:(id)object;

@end
