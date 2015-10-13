//
//  KGGiftListCell.m
//  agrBankWallet
//
//  Created by lianzhandong on 15/10/13.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGGiftListCell.h"

@implementation KGGiftListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillCellWithObject:(id)object{
    self.giftNameLbl.text = object[@"giftName"];
}

@end
