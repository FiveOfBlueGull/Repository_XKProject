//
//  KGSubmitVC.m
//  agrBankWallet
//
//  Created by Neely on 15/10/11.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//



#import "KGSubmitVC.h"
#import "KGInputVC.h"
#import "FormModel.h"
#import "TRMenuPicker.h"
#import "CreatQRImage.h"

#define PCellTitle @"title"
#define PcellDesc @"desc"


@interface KGSubmitVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,TRMenuPickerDelegate>

@property (nonatomic,strong) NSDictionary *titleDic;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) FormModel *formModel;

@property (nonatomic,strong) NSArray *jumpArray; //需要弹出 视图的 选项 －

@property (nonatomic,strong) NSArray *datas;

@property (nonatomic,strong) NSString *currTag; //当前的tag 选项

@end

@implementation KGSubmitVC


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        
        self.titleDic = @{@"0":@"预约存款",
                          @"1":@"预约取款",
                          @"2":@"预约咨询",
                          @"3":@"预约咨询"
                          };
        self.jumpArray = @[@"0_1_1",@"0_1_2",@"1_1_1",@"1_1_2",@"2_1_0"];
        self.dataSource = [NSMutableArray array];
        self.formModel = [[FormModel alloc] init];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = [self.titleDic objectForKey:[NSString stringWithFormat:@"%zd",(NSInteger)self.type]];
    [self.rootTabBarVC setTabBarHidden:YES animated:YES];
    [self.view addSubview:self.tableView];
    [self _setRightBarItem];
    
}

- (void)goBack{
    
    [self.rootTabBarVC setTabBarHidden:NO animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self _loadDataSource];
    [self.tableView reloadData];

}

#pragma mark - getter -
- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 64,self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    }
    return _tableView;
}



#pragma mark - private - 
- (void)_loadDataSource{
    
//   self.formModel.aAddress
    [self.dataSource removeAllObjects];
    NSDictionary *dic1 = @{PCellTitle:@"姓名",PcellDesc:self.formModel.aName};
    NSDictionary *dic2 = @{PCellTitle:@"电话",PcellDesc:self.formModel.aPhoneNum};
    NSDictionary *dic3 = @{PCellTitle:@"证件号码",PcellDesc:self.formModel.aIdCard};
    NSDictionary *dic4 = @{PCellTitle:@"地址",PcellDesc:self.formModel.aAddress};
    
    
    NSDictionary *dic5 = @{PCellTitle:@"存款金额",PcellDesc:self.formModel.aMoney};
    NSDictionary *dic6 = @{PCellTitle:@"存期",PcellDesc:self.formModel.aDeterm};
    NSDictionary *dic7 = @{PCellTitle:@"支取方式",PcellDesc:self.formModel.aWay};

    
    NSDictionary *dic8 = @{PCellTitle:@"取款金额",PcellDesc:self.formModel.aMoney};
   // NSDictionary *dic9 = @{PCellTitle:@"取款日期",PcellDesc:self.formModel.aDate};
    NSDictionary *dic10 = @{PCellTitle:@"取款网点",PcellDesc:self.formModel.aZone};
    
    NSDictionary *dic11 = @{PCellTitle:@"咨询项目",PcellDesc:self.formModel.aItem};


    //预约存款
    if (self.type == ApplyType1) {
        NSArray *array1 = @[dic1,dic2,dic3,dic4];
        NSArray *array2 = @[dic5,dic6,dic7];
        [self.dataSource addObject:array1];
        [self.dataSource addObject:array2];

        return ;
    }
    
    //预约取款
    if (self.type == ApplyType2) {
        NSArray *array1 = @[dic1,dic2,dic3,dic4];
        NSArray *array2 = @[dic8,dic10];
        [self.dataSource addObject:array1];
        [self.dataSource addObject:array2];
        
        return ;
    }
    
    //预约咨询
    if (self.type == ApplyType3) {
        NSArray *array1 = @[dic1,dic2,dic3,dic4];
        NSArray *array2 = @[dic11];
        [self.dataSource addObject:array1];
        [self.dataSource addObject:array2];

        return ;
    }




    
    
    
}


- (void)_setRightBarItem{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];
    self.navigationItem.rightBarButtonItem = item;
}


- (void)_didSelectWithTag:(NSString *)tag{
    
    self.currTag = tag;

    self.datas = [NSArray array];
    if ([tag isEqualToString:@"0_1_1"]) { //存期
        self.datas = @[@"三月",@"六月",@"一年",@"两年",@"三年",@"五年"];
    }
    
    if ([tag isEqualToString:@"0_1_2"]) { //支取方式
        self.datas = @[@"无",@"密码",@"证件"];
    }
    
//    if ([tag isEqualToString:@"1_1_1"]) { //取款日期
//     //   self.datas = @[@"三月",@"六月",@"一年",@"两年",@"三年",@"五年"];
//    }
    
    if([tag isEqualToString:@"1_1_1"]){
        self.datas = @[@"网点一",@"网点二",@"网点三",@"网点四"];

    }
    
    if ([tag isEqualToString:@"2_1_0"]) { //咨询项目
        self.datas = @[@"投资理财",@"分期业务",@"信用卡",@"其他"];
    }

    TRMenuPicker *picke = [[TRMenuPicker alloc] init];
    picke.datas = self.datas;
    picke.delegate = self;
    [picke show];

    
    
    
}


- (void)_modifyFormModelApplyFirstWith:(NSString *)string tag:(NSString *)tag{
    
    if ([tag isEqualToString:@"1_0"]) {
        
        self.formModel.aMoney = string;
    }
    
    if ([tag isEqualToString:@"1_1"]) {
        
        self.formModel.aDeterm = string;
    }
    
    if ([tag isEqualToString:@"1_2"]) {
        
        self.formModel.aWay = string;
    }
    
}

- (void)_modifyFormModelApplySecondWith:(NSString *)string  tag:(NSString *)tag{
    
    if ([tag isEqualToString:@"1_0"]) {
        
        self.formModel.aMoney = string;
    }

    if ([tag isEqualToString:@"1_2"]) {
        
        self.formModel.aZone = string;
    }

    
}


- (void)_modifyFormModelApplyThirdWith:(NSString *)string  tag:(NSString *)tag{
    
    
}


#pragma mark - action - 
- (void)rightAction:(UIBarButtonItem *)sender{
    

    if (self.formModel.aName.length == 0 || self.formModel.aPhoneNum.length == 0 || self.formModel.aIdCard.length == 0 || self.formModel.aAddress.length == 0) {
        
        NSString *message = @"请完善信息";
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertV show];
        return ;
    }
    
    AVObject *obj = [[AVObject alloc] initWithClassName:@"FormClass"];
    
    [obj setObject:self.globalDataModel.userPhone forKey:@"FormUserID"];
    [obj setObject:self.formModel.aName forKey:@"FormUserName"];
    [obj setObject:self.formModel.aPhoneNum forKey:@"FormUserPhone"];
    [obj setObject:self.formModel.aIdCard forKey:@"FormUserIDCard"];
    [obj setObject:self.formModel.aAddress forKey:@"FormUserAddress"];
    [obj setObject:[NSString stringWithFormat:@"%zd",self.type] forKey:@"FormType"];


    
    if(self.type == ApplyType1){ //预约存款
        
        if (self.formModel.aMoney.length == 0 && self.formModel.aWay.length == 0) {
            
            NSString *message = @"请完善信息";
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertV show];
            
            return ;

        }
        
        [obj setObject:self.formModel.aMoney forKey:@"FormMoney"];
        [obj setObject:self.formModel.aWay forKey:@"FormWay"];
        [obj setObject:self.formModel.aDeterm forKey:@"FormDepositTerm"];
        
        

    }
    
    if(self.type == ApplyType2){ //预约取款
        
        if (self.formModel.aMoney.length == 0 && self.formModel.aZone.length == 0) {
            
            NSString *message = @"请完善信息";
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertV show];
            
            return ;
            
        }
        
        [obj setObject:self.formModel.aMoney forKey:@"FormMoeny"];
        [obj setObject:self.formModel.aZone forKey:@"FormZone"];
        
        
        
    }
    
    if(self.type == ApplyType3){ //预约咨询
        
        if (self.formModel.aItem.length == 0 ) {
            
            NSString *message = @"请完善信息";
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertV show];
            
            return ;
            
        }
        
        [obj setObject:self.formModel.aItem forKey:@"FormCusItem"];
        
    }

    
    
    
    NSString *qrMessage = [NSString stringWithFormat:@"FormType:%@\nFormUserID:%@\nFormUserName:%@\nFormUserPhone:%@\nFormUserIDCard:%@\nFormUserAddress:%@\nFormMoney:%@\nFormWay:%@\nFormDepositTerm:%@\nFormZone:%@\nFormCusItem:%@",[NSString stringWithFormat:@"%zd",self.type],self.globalDataModel.userPhone,self.formModel.aName,self.formModel.aPhoneNum,self.formModel.aIdCard,self.formModel.aAddress,self.formModel.aMoney,self.formModel.aWay,self.formModel.aDeterm,self.formModel.aZone,self.formModel.aItem];
  UIImage *image =   [CreatQRImage QRImageWithString:qrMessage];
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    AVFile *file = [AVFile fileWithData:data];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        
        if(succeeded){
            
            
            NSLog(@" %@",file.url);
            
            [obj setObject:file.url forKey:@"FormQRUrl"];
            
            [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                if (succeeded) {
                    
                    NSString *message = @"提交成功";
                    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alertV show];
                    
                }else{
                    NSString *message = @"提交失败，请稍后再试";
                    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alertV show];
                    
                }
            }];

        }else{
            
            NSString *message = @"二维码生成失败，请重试";
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertV show];

        }
        
        
    }];
    
    
    

    
//    NSLog(@"提交");
}


#pragma mark - tableView dataSource - 
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 10;
    }
    return 20;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
  return  [[self.dataSource objectAtIndex:section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdent = [NSString stringWithFormat:@"%zd_%zd",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdent];
    }
    
    NSDictionary *dic = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:PCellTitle];
    cell.detailTextLabel.text = [dic objectForKey:PcellDesc];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - tableView delegate -
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *jumpTag = [NSString stringWithFormat:@"%zd_%zd_%zd",self.type,indexPath.section,indexPath.row];
    
    if ([self.jumpArray containsObject:jumpTag]) {
        [self _didSelectWithTag:jumpTag];

        return ;
    }
    
    
    
    KGInputVC *inputVC = [[KGInputVC alloc] init];
    NSDictionary *dic = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSString *typeName = [dic objectForKey:PCellTitle];
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        inputVC.editType = EditTypePhone;
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        
        inputVC.editType = EditTypeIDCard;
    }
    
    NSRange range = [typeName rangeOfString:@"金额"];
    if (range.location != NSNotFound ) {
        
        inputVC.editType = EditTypeMoney;
    }
    
    inputVC.navigationItem.title   = typeName;
    inputVC.placeHolder = [NSString stringWithFormat:@"请输入%@",[dic objectForKey:PCellTitle]];
    
    __weak typeof(self) weakSelf = self;
    inputVC.callBack = ^(NSString *string){
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            weakSelf.formModel.aName = string;
        }
        if (indexPath.section == 0 && indexPath.row == 1) {
            weakSelf.formModel.aPhoneNum = string;
        }
        if (indexPath.section == 0 && indexPath.row == 2) {
            weakSelf.formModel.aIdCard = string;
        }

        if (indexPath.section == 0 && indexPath.row == 3) {
            weakSelf.formModel.aAddress = string;
        }

        NSString *tag = [NSString stringWithFormat:@"%zd_%zd",indexPath.section,indexPath.row];
        
        if (weakSelf.type == ApplyType1) {
            
            [weakSelf _modifyFormModelApplyFirstWith:string tag:tag];
        }
        
        if (weakSelf.type == ApplyType2) {
            
            [weakSelf _modifyFormModelApplySecondWith:string tag:tag];
        }
        
        if (weakSelf.type == ApplyType3) {
            
            [weakSelf _modifyFormModelApplyThirdWith:string tag:tag];
        }
        
        
    };
    
    
    [self.navigationController pushViewController:inputVC animated:YES];
}


#pragma mark - alertView delegate - 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - trmenupicker - - 
- (void)menuPicker:(TRMenuPicker *)menuPicker didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    

    NSString *string = [self.datas objectAtIndex:row];
    
    if ([self.currTag isEqualToString:@"0_1_1"]) { //存期
    
        self.formModel.aDeterm = string;

    }
    
    if ([self.currTag isEqualToString:@"0_1_2"]) { //支取方式
        
        self.formModel.aWay = string;
    }
    
//    if ([self.currTag isEqualToString:@"1_1_1"]) { //取款日期
//        
//    }
    
    if([self.currTag isEqualToString:@"1_1_1"]){ //取款网点

        self.formModel.aZone = string;
    }

    
    if ([self.currTag isEqualToString:@"2_1_0"]) { //咨询项目

        self.formModel.aItem = string;
    }

    [self _loadDataSource];
    [self.tableView reloadData];

    
    
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
