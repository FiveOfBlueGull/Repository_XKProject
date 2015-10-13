//
//  KGLuckyGiftListCell.h
//  agrBankWallet
//
//  Created by lianzhandong on 15/10/12.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGLuckyGiftListCell : UITableViewCell

@property (nonatomic, weak)IBOutlet UIImageView *leftImageView;
@property (nonatomic, weak)IBOutlet UILabel     *nameLbl;
@property (nonatomic, weak)IBOutlet UILabel     *descriptionLbl;

@property (nonatomic, weak)IBOutlet UIButton    *getGiftBtn;

@property (nonatomic, copy)void(^didClickExchangeBtn)(NSInteger index);

- (void)fillWithObject:(id)object index:(NSInteger)index;


@end
