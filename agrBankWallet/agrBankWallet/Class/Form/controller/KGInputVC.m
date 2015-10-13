//
//  KGInputVC.m
//  agrBankWallet
//
//  Created by Neely on 15/10/11.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGInputVC.h"

@interface KGInputVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UITextField *inputText;

@end

@implementation KGInputVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    self.tableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [self _setLeftBarItem];
    [self.view addSubview:self.tableView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)_setLeftBarItem{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backItemImage"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = item;
}


#pragma mark - Action - 
- (void)goBack{
    
    NSString *string = self.inputText.text;
    if (self.editType == EditTypePhone  ) {
        
        if (string.length != 11) {
            
            NSString *message = @"请填写正确的手机号";
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertV show];
            return ;
        }
    }
    
    
    if (self.editType == EditTypeIDCard) {
        
        if (string.length != 18) {
            NSString *message = @"请填写正确的身份证号";
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertV show];
            return ;

        }
    }
    
    if (self.editType == EditTypeMoney) {
        
        NSInteger count = [string integerValue];
        
        if (count <= 0 || count >= 100000) {
            NSString *message = @"请填写金额,不低于1，不高于100000";
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertV show];
            return ;
            
        }
    }

    
    
    
    
    
    if (self.callBack) {
        self.callBack(string);
    }
    
    [self.navigationController popViewControllerAnimated:YES];

}


#pragma mark - getter -
- (UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return _tableView;
}

- (UITextField *)inputText{
    
    if (!_inputText) {
        
        _inputText = [[UITextField alloc] init];
        _inputText.frame = CGRectMake(10, 2, ScreenWidth - 20, 40);
        _inputText.clearButtonMode = UITextFieldViewModeWhileEditing;
        _inputText.placeholder = self.placeHolder;
        
    }
    return _inputText;
}

- (UIView *)_getLineWithFrame:(CGRect )frame{
    
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
    return line;
}


#pragma mark --- tebleView  dataSourece - 

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIden = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIden];
       
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addSubview:[self _getLineWithFrame:CGRectMake(0, 0, ScreenWidth, 1/ScreenScale)]];
        [cell addSubview:self.inputText];
        [cell addSubview:[self _getLineWithFrame:CGRectMake(0, 44 - 1/ScreenScale, ScreenWidth, 1/ScreenScale)]];
    }
    
    return cell;
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
