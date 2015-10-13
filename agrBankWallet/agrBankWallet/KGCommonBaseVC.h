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

@property (nonatomic, strong)GlobalDataModel   *globalDataModel; /**< 全局的单例数据模型 */

@property (nonatomic, weak)RDVTabBarController *rootTabBarVC;    /**< 根TabBarVC */

@property (nonatomic, weak)UIWindow            *window;
/**
 *  初始化方法－－适合于使用Xib的viewController
 *
 *  @param nibNameOrNil   nibNameOrNil
 *  @param nibBundleOrNil nibNameOrNil
 *  @param showing        是否显示自定义回退按钮
 *
 *  @return 继承于KGCommonBaseVC的控制器
 */
- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibNameOrNil
               customBackButton:(BOOL)showing;

/**
 *  初始化方法－－适合食用手写代码的ViewController
 *
 *  @param showing 是否显示自定义回退按钮
 *
 *  @return 继承于KGCommonBaseVC的控制器
 */
- (instancetype)initWithCustomBackButton:(BOOL)showing;
/**
 *  点击会退按钮 pop/dismiss VC 需之类重写
 */
- (void)goBack;

- (void)alertWithMessage:(NSString *)message;

- (void)alertWithMessage:(NSString *)message delay:(NSTimeInterval)delay;
@end
