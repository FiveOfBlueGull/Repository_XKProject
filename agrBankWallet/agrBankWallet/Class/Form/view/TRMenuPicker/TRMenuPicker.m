//
//  TRMenuPicker.m
//  WJTR
//
//  Created by Brian on 15/8/29.
//  Copyright (c) 2015年 TYRBL. All rights reserved.
//

#import "TRMenuPicker.h"

#define toolbarHeight 40
#define pickerViewHeight 216
#define toolbarY (ScreenHeight - pickerViewHeight - toolbarHeight)

@interface TRMenuPicker () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, weak) UIPickerView *pickerView;
@property (nonatomic, weak) UIToolbar *toolbar;

@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) NSInteger component;

@end

@implementation TRMenuPicker

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]) {
        [self setupPicker];
        [self setupToolbarWithY:toolbarY];
    }
    return self;
}

+ (instancetype)menuPicker
{
    return [[self alloc] init];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        _pickerView.frame = CGRectMake(0, ScreenHeight - pickerViewHeight, ScreenWidth, pickerViewHeight);
        _toolbar.frame = CGRectMake(0, toolbarY, ScreenWidth, toolbarHeight);
    }];
}

#pragma mark - private Method
- (void)setupPicker
{
    UIPickerView *pickerView=[[UIPickerView alloc] init];
    
    pickerView.frame=CGRectMake(0, ScreenHeight + toolbarHeight, ScreenWidth, pickerViewHeight);
    pickerView.backgroundColor=[UIColor whiteColor];
    pickerView.delegate=self;
    pickerView.dataSource=self;
    [self addSubview:pickerView];
    self.pickerView = pickerView;
}

- (void)setupToolbarWithY:(CGFloat)y
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, toolbarHeight)];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelItemClick)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneItemClick)];
    
    toolbar.items = @[cancelItem, spaceItem, doneItem];
    [self addSubview:toolbar];
    self.toolbar = toolbar;
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        _pickerView.frame = CGRectMake(0, ScreenHeight + toolbarHeight, ScreenWidth, pickerViewHeight);
        _toolbar.frame = CGRectMake(0, ScreenHeight, ScreenWidth, toolbarHeight);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}

#pragma mark - action Method
- (void)cancelItemClick
{
    [self hide];
}

- (void)doneItemClick
{
    [self hide];
    if (_delegate && [_delegate respondsToSelector:@selector(menuPicker:didSelectRow:inComponent:)]) {
        [_delegate menuPicker:self didSelectRow:_row inComponent:_component];
    }
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.datas.count;
}

#pragma mark - UIPickerViewDelegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] init];
    label.text = [self.datas objectAtIndex:row];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _row = row;
    _component = component;
}

#pragma mark - setter Method
- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    
    [self.pickerView reloadAllComponents];
}

- (void)setBgColor:(UIColor *)bgColor
{
    _bgColor = bgColor;
    
    self.pickerView.backgroundColor = bgColor;
}


@end
