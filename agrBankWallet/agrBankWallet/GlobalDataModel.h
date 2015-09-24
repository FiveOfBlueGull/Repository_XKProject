//
//  GlobalDataModel.h
//  autoresizingMaskText
//
//  Created by system on 15/4/13.
//  Copyright (c) 2015年 system. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalDataModel : NSObject

@property (nonatomic, copy)NSString *userName;       /**< 用户名 */

@property (nonatomic, copy)NSString *userAccount;    /**< 用户积分 */

@property (nonatomic, copy)NSString *userPhone;      /**< 用户手机号 */

@property (nonatomic, copy)NSString *userNick;       /**< 用户昵称 */

@property (nonatomic, copy)NSString *userPassword;   /**<  用户密码 */

@property (nonatomic, strong)NSNumber *userType;     /**< 用户类型 */

+ (id)shareInstance;

/**
 *  是否登录
 *
 *  @return 登录与否
 */
- (BOOL)isLogin;
/**
 *  注销登录，清空数据
 */
- (void)logout;
/**
 *  本地的登录
 *
 *  @param info 从数据库获取的用户信息
 */
- (void)didLoginWithReturnInfo:(NSDictionary *)info;

@end
