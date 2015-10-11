//
//  KGIntroCell.m
//  agrBankWallet
//
//  Created by Neely on 15/10/1.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGIntroCell.h"

#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight     [UIScreen mainScreen].bounds.size.height
#define ScreenScale     [UIScreen mainScreen].scale


@interface KGIntroCell ()

@property (nonatomic,strong) UIView *aGrayView;
@property (nonatomic,strong) UIView *aLine;
@end

@implementation KGIntroCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        [self _setSubViews];
    }
    return self;
}

#pragma  mark - getter - 
- (UIImageView *)aImageView{
    
    if (!_aImageView) {
        _aImageView = [[UIImageView alloc] init];
    }
    return _aImageView;
}

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

- (UIView *)aGrayView{
    
    if(!_aGrayView){
        
        _aGrayView = [[UIView alloc] init];
        _aGrayView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.3];

    }
    return _aGrayView;
}

- (UIView *)aLine{
    
    if (!_aLine) {
        _aLine = [[UIView alloc] init];
        _aLine.backgroundColor = [UIColor colorWithRed:194/255.0 green:194/255.0 blue:194/255.0 alpha:1];
    }
   return  _aLine;
}


- (void)layoutSubviews{
    
    if (self.aStyle == CellStyleFull) {
        
        self.aImageView.frame = CGRectMake(0, 0, ScreenWidth, KFullHeight);
        
        self.aTitleLabel.frame = CGRectMake(10,KFullHeight - 50, ScreenWidth - 20, 50);
        self.aGrayView.frame = CGRectMake(0, KFullHeight - 50, ScreenWidth, 50);
        
        self.aLine.frame = CGRectMake(10, KFullHeight - 1/ScreenScale, ScreenWidth - 10, 1/ScreenScale);
    }
    
    if (self.aStyle == CellStyleHalf) {
        
        self.aImageView.frame = CGRectMake(10, 10, KHalfHeight - 20, KHalfHeight - 20);
        self.aTitleLabel.frame = CGRectMake(KHalfHeight, 10, ScreenWidth - 80 , KHalfHeight -20);
        self.aGrayView.frame = CGRectZero;
        self.aLine.frame = CGRectMake(10, KHalfHeight - 1/ScreenScale, ScreenWidth - 10, 1/ScreenScale);


    }
}

#pragma mark - private - 
- (void)_setSubViews{
    
    [self addSubview:self.aImageView];
    [self addSubview:self.aGrayView];
    [self addSubview:self.aTitleLabel];
    [self addSubview:self.aLine];
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
