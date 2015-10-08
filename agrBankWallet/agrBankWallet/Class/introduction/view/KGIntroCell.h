//
//  KGIntroCell.h
//  agrBankWallet
//
//  Created by Neely on 15/10/1.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KFullHeight 140.0
#define KHalfHeight 70.0

typedef enum{
    
    CellStyleFull = 1, //图片占 整个cell
    CellStyleHalf = 2 // 小图片
}CellStyle;

@interface KGIntroCell : UITableViewCell

@property (nonatomic,strong) UIImageView *aImageView;
@property (nonatomic,strong) UILabel *aTitleLabel;

@property (nonatomic,assign) CellStyle aStyle;

@end
