//
//  KGGiftListCell.h
//  agrBankWallet
//
//  Created by lianzhandong on 15/10/13.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGGiftListCell : UITableViewCell

@property (nonatomic, weak)IBOutlet UIImageView *bgImageView;
@property (nonatomic, weak)IBOutlet UILabel     *giftNameLbl;


- (void)fillCellWithObject:(id)object;

@end
