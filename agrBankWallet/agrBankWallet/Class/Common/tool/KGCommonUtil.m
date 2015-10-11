//
//  KGCommonUtil.m
//  agrBankWallet
//
//  Created by lianzhandong on 15/10/4.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGCommonUtil.h"

@implementation KGCommonUtil


+ (instancetype)shareInstance{
    static KGCommonUtil *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[KGCommonUtil alloc] init];
    });
    return instance;
}

- (CGFloat)getLabelLength:(NSString *)strString font:(UIFont*)font height:(CGFloat)height{
    CGSize size = CGSizeMake(MAXFLOAT, height);
    CGFloat newPriceWidth = 0.0f;
    if ([strString respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
        CGSize  actualsize =[strString boundingRectWithSize:size
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:tdic context:nil].size;
        newPriceWidth=actualsize.width;
        
    }else{
        newPriceWidth= [strString sizeWithFont:font
                             constrainedToSize:size
                                 lineBreakMode:NSLineBreakByWordWrapping].width;
    }
    return newPriceWidth;
}

- (CGFloat)getLabelHeight:(NSString *)strString font:(UIFont*)font width:(CGFloat)width{
    CGSize size = CGSizeMake(width, MAXFLOAT);
    CGFloat newHeight = 0.0f;
    if ([strString respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
        CGSize  actualsize =[strString boundingRectWithSize:size
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:tdic context:nil].size;
        newHeight=actualsize.height;
        
    }else{
        newHeight= [strString sizeWithFont:font
                             constrainedToSize:size
                                 lineBreakMode:NSLineBreakByWordWrapping].height;
    }
    return newHeight;
}

@end
