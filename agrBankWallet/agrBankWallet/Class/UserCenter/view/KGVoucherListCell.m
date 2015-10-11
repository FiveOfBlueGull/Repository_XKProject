//
//  KGVoucherListCell.m
//  agrBankWallet
//
//  Created by lianzhandong on 15/10/2.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGVoucherListCell.h"

@implementation KGVoucherListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return  self;
}

- (void)awakeFromNib {
    // Initialization code
    [self setup];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setup{
    self.bgImageView.clipsToBounds = YES;
}

- (void)fillWithVoucher:(AVObject *)voucher
               activity:(AVObject *)activity
                   shop:(AVObject *)shop{
    self.leftImageView.hidden = [voucher[@"hasUsed"] integerValue] == 0;
    if (activity) {
        self.activityNameLbl.text = activity[@"ActivityName"];
    }
    if (shop) {
        self.shopNameLbl.text = shop[@"shopName"];
    }
}

@end
