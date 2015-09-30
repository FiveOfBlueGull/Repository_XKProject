//
//  KGIntroVC.m
//  agrBankWallet
//
//  Created by Neely on 15/10/1.
//  Copyright (c) 2015年 lianzhandong. All rights reserved.
//

#import "KGIntroVC.h"

@interface KGIntroVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation KGIntroVC

- (instancetype)init{
    
    if (self = [super init]) {
        
//        self.dataSource = @[@"1",@"2",@"3",@"4",@"5",@"6"].mutableCopy;
        self.dataSource = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"介绍";
    [self.view addSubview:self.tableView];
    
    AVQuery *query = [[AVQuery alloc] initWithClassName:@"ShopClass"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if(!error){
            
            for (AVObject *obj  in objects) {
                
                [self.dataSource addObject:obj];
            }
            
            [self.tableView reloadData];
        }
    }];
    
    
    

    
}


#pragma mark - getter ---- 
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 64,self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


#pragma mark -  tableView dataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdent = @"introCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdent];
    }
    
    AVObject *obj = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = obj[@"shopName"];
    cell.detailTextLabel.text = obj[@"shopAddress"];
    return cell;
}


#pragma mark -- tablview delegate--
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"%zd",indexPath.row);
//    UIImage *image = [UIImage imageNamed:@"gaosibeijing@2x"];
//    NSData *data = UIImageJPEGRepresentation(image, 0.8);
//    AVFile *file = [AVFile fileWithData:data];
//    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        NSLog(@"%zd --- %@",succeeded,file);
//        
//    }];
    
    
//    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//        
//    }];
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
