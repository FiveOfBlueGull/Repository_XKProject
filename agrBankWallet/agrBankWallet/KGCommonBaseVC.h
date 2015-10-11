//
//  KGCommonBaseVC.h
//  agrBankWallet
//
//  Created by lianzhandong on 15/9/23.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalDataModel.h"
#import "RDVTabBarController.h"
#import <AVOSCloud/AVOSCloud.h>


@interface KGCommonBaseVC : UIViewController

@property (nonatomic, strong)GlobalDataModel   *globalDataModel;

@property (nonatomic, weak)RDVTabBarController *rootTabBarVC;

@property (nonatomic, weak)UIWindow            *window;
/**
 *  初始化方法
 *
 *  @param nibNameOrNil   <#nibNameOrNil description#>
 *  @param nibBundleOrNil <#nibBundleOrNil description#>
 *  @param showing        是否显示自定义回退按钮
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
               customBackButton:(BOOL)showing;

/**
 *  初始化方法
 *
 *  @param showing 是否显示自定义回退按钮
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithCustomBackButton:(BOOL)showing;
/**
 *  点击会退按钮 pop/dismiss VC
 */
- (void)goBack;

@end
