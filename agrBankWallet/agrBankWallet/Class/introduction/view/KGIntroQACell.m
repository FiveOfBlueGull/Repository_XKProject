//
//  KGIntroQACell.m
//  agrBankWallet
//
//  Created by Neely on 15/10/4.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGIntroQACell.h"

@implementation KGIntroQACell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self _setSubViews];
    }
    
    return self;
}


- (void)setAIsSelect:(BOOL)aIsSelect{
    
    _aIsSelect = aIsSelect;
    if (aIsSelect) {
        
        self.aTitleLabel.textColor = [UIColor orangeColor];
        
    }else{
        self.aTitleLabel.textColor = [UIColor blackColor];
        
    }
}
#pragma mark - getter -

- (UILabel *)aTitleLabel{
    
    if (!_aTitleLabel) {
        
        _aTitleLabel= [[UILabel alloc] init];
        _aTitleLabel.textAlignment = NSTextAlignmentLeft;
        _aTitleLabel.numberOfLines = 0;
        _aTitleLabel.textColor = [UIColor blackColor];
        _aTitleLabel.backgroundColor = [UIColor clearColor];
    }
    return _aTitleLabel;
}


#pragma mark - private -
- (void)_setSubViews{
    [self addSubview:self.aTitleLabel];
}



- (void)layoutSubviews{
    
    if (self.aType == CellTypeQuest) {
        
        self.aTitleLabel.frame = CGRectMake(10,10 , ScreenWidth - 20 , self.aHeight - 20);
        self.aTitleLabel.font = [UIFont systemFontOfSize:17];
    }
    
    if (self.aType == CellTypeAnswer) {
        
        self.aTitleLabel.frame = CGRectMake(15, 5, ScreenWidth - 30, self.aHeight - 10);
        self.aTitleLabel.font = [UIFont systemFontOfSize:14];
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
