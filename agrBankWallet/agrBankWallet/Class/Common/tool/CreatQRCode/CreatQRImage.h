//
//  CreatQRImage.h
//  WJTR
//
//  Created by TYRBL on 15/8/20.
//  Copyright (c) 2015年 TYRBL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreatQRImage : NSObject


+ (UIImage *)QRImageWithString:(NSString *)message;

//+ (UIImage *)QRImageOfCurrUser;

@end
