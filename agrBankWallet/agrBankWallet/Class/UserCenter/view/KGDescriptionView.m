//
//  KGDescriptionView.m
//  agrBankWallet
//
//  Created by lianzhandong on 15/10/4.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGDescriptionView.h"
#import "KGCommonUtil.h"

#define kLeftLblFont [UIFont systemFontOfSize:18.0f]
#define kRightLblFont [UIFont systemFontOfSize:18.0f]

#define kLeftLblTextColor [UIColor blackColor]
#define kRightLblTextColor [UIColor blackColor]

@interface KGDescriptionView ()

@property (nonatomic, strong)UILabel *leftLbl;
@property (nonatomic, strong)UILabel *rightLbl;

@property (nonatomic, strong)UIView *topLineView;
@property (nonatomic, strong)UIView *bottomLineView;

@end

@implementation KGDescriptionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithWidth:(CGFloat)width
                   leftString:(NSString *)leftString
                  rightString:(NSString *)rightString
                   isFistItem:(BOOL)isFist
                   isLastItem:(BOOL)isLast{
    CGFloat leftLblWidth = 0.0f;
    if (leftString) {
        leftLblWidth = [[KGCommonUtil shareInstance] getLabelLength:leftString font:kLeftLblFont height:MAXFLOAT];
        leftLblWidth = (leftLblWidth > width * 0.25) ? width * 0.25 : leftLblWidth;
    }
    CGFloat rightLblHeight = [[KGCommonUtil shareInstance] getLabelHeight:rightString font:kRightLblFont width:width - leftLblWidth];
    self = [super initWithFrame:CGRectMake(0, 0, width, rightLblHeight)];
    if (self) {
        [self setupLeftLblWithFrame:CGRectMake(0, 0, leftLblWidth, rightLblHeight) string:leftString];
        [self setupRightLblWithFrame:CGRectMake(leftLblWidth, 0, width - leftLblWidth, rightLblHeight) string:rightString];
        if (isFist) {
            self.topLineView.hidden = NO;
            self.topLineView.frame = CGRectMake(0, 0, width, 1);
        }else{
            self.topLineView.hidden = YES;
        }
        CGFloat distanceToLeft = 0.0f;
        if (isLast) {
            self.bottomLineView.frame = CGRectMake(0, rightLblHeight - 1, width, 1);
        }else{
            distanceToLeft = (leftLblWidth == 0.0f) ? width * 0.1 : leftLblWidth;
            self.bottomLineView.frame = CGRectMake(distanceToLeft, rightLblHeight - 1, width - distanceToLeft, 1);
        }
    }
    return self;
}

#pragma mark -- set/get

- (UIView *)topLineView{
    if (_topLineView == nil) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_topLineView];
    }
    return _topLineView;
}

- (UIView *)bottomLineView{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_bottomLineView];
    }
    return _bottomLineView;
}

#pragma mark --

- (void)setupLeftLblWithFrame:(CGRect)frame string:(NSString *)text{
    self.leftLbl = [[UILabel alloc] initWithFrame:frame];
    self.leftLbl.textAlignment = NSTextAlignmentLeft;
    self.leftLbl.numberOfLines = 0;
    self.leftLbl.font = kLeftLblFont;
    self.leftLbl.text = text;
    self.leftLbl.textColor = kLeftLblTextColor;
    [self addSubview:self.leftLbl];
}

- (void)setupRightLblWithFrame:(CGRect)frame string:(NSString *)text{
    self.rightLbl = [[UILabel alloc] initWithFrame:frame];
    self.rightLbl.textAlignment = NSTextAlignmentLeft;
    self.rightLbl.numberOfLines = 0;
    self.rightLbl.font = kRightLblFont;
    self.rightLbl.text = text;
    self.rightLbl.textColor = kRightLblTextColor;
    [self addSubview:self.rightLbl];
}

@end
