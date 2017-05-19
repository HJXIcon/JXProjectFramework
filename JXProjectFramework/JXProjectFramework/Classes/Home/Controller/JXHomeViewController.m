//
//  JXHomeViewController.m
//  JXProjectFramework
//
//  Created by mac on 17/5/19.
//  Copyright © 2017年 JXIcon. All rights reserved.
//

#import "JXHomeViewController.h"
#import "JXHomePageCell.h"
#import "JXHomePageViewModel.h"

@interface JXHomeViewController ()<UITableViewDataSource>

@property (strong, nonatomic)  UITableView *tableView;

// vm
@property (strong, nonatomic) JXHomePageViewModel *viewModel;

@end

@implementation JXHomeViewController

#pragma mark - lazy loading
- (JXHomePageViewModel *)viewModel {
    
    if (_viewModel == nil) {
        _viewModel = [[JXHomePageViewModel alloc]init];
    }
    return _viewModel;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        [_tableView registerClass:[JXHomePageCell class] forCellReuseIdentifier:HomeCellIdentifier];
        
    }
    return _tableView;
}

- (void)loadView{
    [super loadView];
    self.view = self.tableView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = [JXHomePageCell getCellHeight];
    
    [self sendRequest];
}


// 发起请求
- (void)sendRequest {
    
    @weakify(self);
    [self.viewModel.requestSignal subscribeNext:^(NSArray *articles) {
        
        @strongify(self);
        // 请求完成后，刷新表格
        [self.tableView reloadData];
        
    } error:^(NSError *error) {
        // 如果请求失败，则根据error做出相应提示
        NSString *msg = [[error userInfo] objectForKey:GlobalErrorMessageKey];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:NULL];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:NULL];
    }];
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JXHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeCellIdentifier];
    
    // 将数据赋值给cell的vm
    // cell接收到vm修改以后，就会触发初始时设置的信号量
    cell.viewModel = self.viewModel.dataSource[indexPath.row];
    
    
    return cell;
}

@end
