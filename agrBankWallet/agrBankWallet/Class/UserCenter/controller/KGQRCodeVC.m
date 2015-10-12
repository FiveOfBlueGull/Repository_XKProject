//
//  KGQRCodeVC.m
//  agrBankWallet
//
//  Created by guowenrui on 15/10/12.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGQRCodeVC.h"
#import "QRCodeGenerator.h"
#import <QuartzCore/QuartzCore.h>

@interface KGQRCodeVC ()<UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *QRCodeView;

@end

@implementation KGQRCodeVC

- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"优惠码";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIColor *selfViewBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"qrCodeBackground"]];
    
    [self.view setBackgroundColor:selfViewBackgroundColor];
    
    NSString *_couponCode;
    if (_activityObject[@"ActivityName"]) {
        _nameLabel.text = _activityObject[@"ActivityName"];
        _infoLabel.text = _activityObject[@"ActivityDescription"];
        _couponCode = [NSString stringWithFormat:@"%@&%@&%@&%@", _activityObject[@"ActivityName"], _activityObject[@"ActivityDescription"], _targetObject.objectId, _targetObject.createdAt];
    } else {
        _nameLabel.text = _activityObject[@"shopName"];
        _infoLabel.text = _activityObject[@"shopAddress"];
        _couponCode = [NSString stringWithFormat:@"%@&%@&%@&%@", _activityObject[@"shopName"], _activityObject[@"shopAddress"], _targetObject.objectId, _targetObject.createdAt];
    }
    _couponCode = @"王神你真帅！";
    UIImage *qrcodeImage = [QRCodeGenerator qrImageForString:_couponCode imageSize:_QRCodeView.frame.size.width];
    self.QRCodeView.image = qrcodeImage;
    
    self.QRCodeView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(savePhotoToAlbum:)];
    
    singleTap.numberOfTapsRequired = 1;
    
    [self.QRCodeView addGestureRecognizer:singleTap];
}

- (void)savePhotoToAlbum:(UITapGestureRecognizer*)singleTap
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存到手机", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self saveImage];
    }
}

- (void)saveImage
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIGraphicsBeginImageContext(self.bgView.bounds.size);
        
        [self.bgView.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage *photoImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        UIImageWriteToSavedPhotosAlbum(photoImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    });
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        
    } else {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
