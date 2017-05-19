//
//  JXHomePageViewModel.h
//  JXProjectFramework
//
//  Created by mac on 17/5/19.
//  Copyright © 2017年 JXIcon. All rights reserved.
//

#import "JXRequestViewModel.h"
#import "SQLInterface.h"

// vc的vm
// 因为需要进行数据缓存，所以遵循SQLInterface
// 因为需要进行网络请求，所以继承自RequestViewModel
@interface JXHomePageViewModel : JXRequestViewModel<SQLInterface>

@property (strong, nonatomic) RACSignal *requestSignal; ///< 网络请求信号量

@property (assign, nonatomic) NSInteger currentPage; ///< 当前页码
@property (strong, nonatomic) NSArray *dataSource; ///< tableView的数据源

@end
