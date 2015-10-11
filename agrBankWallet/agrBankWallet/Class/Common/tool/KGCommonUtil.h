//
//  KGCommonUtil.h
//  agrBankWallet
//
//  Created by lianzhandong on 15/10/4.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KGCommonUtil : NSObject

+ (instancetype)shareInstance;

- (CGFloat)getLabelLength:(NSString *)strString font:(UIFont*)font height:(CGFloat)height;
- (CGFloat)getLabelHeight:(NSString *)strString font:(UIFont*)font width:(CGFloat)width;
@end
