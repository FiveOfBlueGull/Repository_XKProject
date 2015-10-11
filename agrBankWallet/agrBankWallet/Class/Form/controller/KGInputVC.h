//
//  KGInputVC.h
//  agrBankWallet
//
//  Created by Neely on 15/10/11.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallBack)(NSString *string);

@interface KGInputVC : UIViewController

@property (nonatomic,strong) NSString *placeHolder;

@property (nonatomic,copy) CallBack callBack;
@end
