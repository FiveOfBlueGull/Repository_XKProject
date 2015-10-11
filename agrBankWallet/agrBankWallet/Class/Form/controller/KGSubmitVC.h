//
//  KGSubmitVC.h
//  agrBankWallet
//
//  Created by Neely on 15/10/11.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGCommonBaseVC.h"

typedef enum{
    
    ApplyType1 = 0,
    ApplyType2 = 1,
    ApplyType3 = 2,
    ApplyType4 = 3
}ApplyType;

@interface KGSubmitVC : KGCommonBaseVC


@property (nonatomic,assign) ApplyType type;

@end
