//
//  TRMenuPicker.h
//  WJTR
//
//  Created by Brian on 15/8/29.
//  Copyright (c) 2015年 TYRBL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TRMenuPicker;

@protocol TRMenuPickerDelegate <NSObject>

- (void)menuPicker:(TRMenuPicker *)menuPicker didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end

@interface TRMenuPicker : UIView

@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, weak) id<TRMenuPickerDelegate> delegate;

@property (nonatomic, strong) UIColor *bgColor;

+ (instancetype)menuPicker;

- (void)show;

@end
