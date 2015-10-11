//
//  KGDescriptionView.h
//  agrBankWallet
//
//  Created by lianzhandong on 15/10/4.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGDescriptionView : UIView

- (instancetype)initWithWidth:(CGFloat)width
                   leftString:(NSString *)leftString
                  rightString:(NSString *)rightString
                   isFistItem:(BOOL)isFist
                   isLastItem:(BOOL)isLast;
@end
