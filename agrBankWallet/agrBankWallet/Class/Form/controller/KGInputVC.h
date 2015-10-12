//
//  KGInputVC.h
//  agrBankWallet
//
//  Created by Neely on 15/10/11.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    EditTypeName = 0,
    EditTypePhone = 1,
    EditTypeIDCard = 2,
    EditTypeAddress = 3,
    EditTypeMoney = 4
    
}EditType;

typedef void(^CallBack)(NSString *string);

@interface KGInputVC : UIViewController

@property (nonatomic,strong) NSString *placeHolder;

@property (nonatomic,copy) CallBack callBack;

@property (nonatomic,assign) EditType editType;
@end
