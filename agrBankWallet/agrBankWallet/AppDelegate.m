//
//  AppDelegate.m
//  agrBankWallet
//
//  Created by lianzhandong on 15/9/23.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "AppDelegate.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "KGCommonBaseVC.h"
#import "KGCommonBaseNVC.h"
#import "KGLoginVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.window makeKeyAndVisible];
    
    NSDictionary *imgDic1 = @{@"Default":[UIImage imageNamed:@"3tagTabPicNormal.png"],
                              @"Seleted":[UIImage imageNamed:@"3tagTabPicSelected.png"]};
    NSDictionary *imgDic2 = @{@"Default":[UIImage imageNamed:@"3tagTabFindNormal.png"],
                              @"Seleted":[UIImage imageNamed:@"3tagTabFindSelected.png"]};
    NSDictionary *imgDic3 = @{@"Default":[UIImage imageNamed:@"3tagTabHomeNormal"],
                              @"Seleted":[UIImage imageNamed:@"3tagTabHomeSelected"]};
    NSDictionary *imgDic4 = @{@"Default":[UIImage imageNamed:@"3tagTabMeNormal.png"],
                              @"Seleted":[UIImage imageNamed:@"3tagTabMeSelected.png"]};
    
    KGCommonBaseVC *introductionVC = [[KGCommonBaseVC alloc] init];
    KGCommonBaseNVC *nvc1 = [[KGCommonBaseNVC alloc] initWithRootViewController:introductionVC];
    
    KGCommonBaseVC *activityVC = [[KGCommonBaseVC alloc] init];
    KGCommonBaseNVC *nvc2 = [[KGCommonBaseNVC alloc] initWithRootViewController:activityVC];
    
    KGCommonBaseVC *formVC = [[KGCommonBaseVC alloc] init];
    KGCommonBaseNVC *nvc3 = [[KGCommonBaseNVC alloc] initWithRootViewController:formVC];
    
    KGCommonBaseVC *userCenterVC = [[KGLoginVC alloc] initWithNibName:@"KGLoginVC" bundle:nil];
    KGCommonBaseNVC *nvc4 = [[KGCommonBaseNVC alloc] initWithRootViewController:userCenterVC];
    
    RDVTabBarController *tbVC = [[RDVTabBarController alloc] init];
    [tbVC setViewControllers:@[nvc1, nvc2, nvc3, nvc4]];
    [self customizeTabBarForController:tbVC imageArray:@[imgDic1, imgDic2, imgDic3, imgDic4]];
    
    self.window.rootViewController = tbVC;
    
    return YES;
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController imageArray:(NSArray *)array{
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [array objectAtIndex:index][@"Seleted"];
        UIImage *unselectedimage = [array objectAtIndex:index][@"Default"];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
