//
//  KGVoucherListCell.m
//  agrBankWallet
//
//  Created by lianzhandong on 15/10/2.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGVoucherListCell.h"
#import "UIImageView+WebCache.h"

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
    self.leftImageView.hidden = NO;
    
    if (activity) {
        self.activityNameLbl.text = activity[@"ActivityName"];
        self.shopNameLbl.text = activity[@"ActivityDescription"];
        self.bgImageView.contentMode = UIViewContentModeCenter;
        [self.bgImageView sd_setImageWithURL:activity[@"pictureUrl"] placeholderImage:[UIImage imageNamed:@"defaultMallImage"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                self.bgImageView.contentMode = UIViewContentModeScaleAspectFit;
            }
        }];
    }
    if (shop) {
        self.activityNameLbl.text = shop[@"shopName"];
        self.shopNameLbl.text = shop[@"shopAddress"];
    }
}

@end
