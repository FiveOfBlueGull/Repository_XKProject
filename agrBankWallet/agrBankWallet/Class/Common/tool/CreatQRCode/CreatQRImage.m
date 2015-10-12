//
//  CreatQRImage.m
//  WJTR
//
//  Created by TYRBL on 15/8/20.
//  Copyright (c) 2015年 TYRBL. All rights reserved.
//

#import "CreatQRImage.h"

@implementation CreatQRImage



//+(UIImage *)QRImageOfCurrUser{
//    
//    NSString *message =  [NSString stringWithFormat:@"BEGIN:VCARD\nVERSION:3.0\nN:id:%@\nTEL:username:%@\nEND:VCARD",[AppCommon shareAppCommon].currentUser.m_userID,[AppCommon shareAppCommon].currentUser.m_username];
//    
//    return [CreatQRImage QRImageWithString:message];
//}


+ (UIImage *)QRImageWithString:(NSString *)message{
    
    
    return [CreatQRImage createNonInterpolatedUIImageFormCIImage:[CreatQRImage createQRForString:message] withSize:202.f];
}

#pragma mark - QRCodeGenerator .使用系统的生成 二维码 Ciimage －
+ (CIImage *)createQRForString:(NSString *)qrString {
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // Send the image back
    return qrFilter.outputImage;
}


#pragma mark - InterpolatedUIImage
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // create a bitmap image that we'll draw into a bitmap context at the desired size;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // Create an image with the contents of our bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    UIImage *images = [UIImage imageWithCGImage:scaledImage];
    
    // Cleanup
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGImageRelease(scaledImage);
    CGColorSpaceRelease(cs);
    return images;
}


@end
