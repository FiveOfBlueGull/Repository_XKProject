//
//  KGUserCenterCell.m
//  agrBankWallet
//
//  Created by lianzhandong on 15/9/24.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGUserCenterCell.h"

@implementation KGUserCenterCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)fillCellWithObject:(id)object{
    self.titleLbl.text = object;
}

@end
