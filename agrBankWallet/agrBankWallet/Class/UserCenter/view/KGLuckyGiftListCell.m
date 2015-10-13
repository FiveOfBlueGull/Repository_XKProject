//
//  KGLuckyGiftListCell.m
//  agrBankWallet
//
//  Created by lianzhandong on 15/10/12.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGLuckyGiftListCell.h"

@interface KGLuckyGiftListCell  ()

@property (nonatomic, assign)NSInteger index;

@end


@implementation KGLuckyGiftListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillWithObject:(id)object{
    self.nameLbl.text = object[@"giftName"];
    self.descriptionLbl.text = object[@"giftDescription"];
}

- (void)fillWithObject:(id)object index:(NSInteger)index{
    [self fillWithObject:object];
    self.index = index;
}

- (IBAction)handleExchangeBtnAction:(id)sender{
    if (self.didClickExchangeBtn) {
        self.didClickExchangeBtn(self.index);
    }
}

@end
