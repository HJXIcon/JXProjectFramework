//
//  JXHomePageViewModel.m
//  JXProjectFramework
//
//  Created by mac on 17/5/19.
//  Copyright © 2017年 JXIcon. All rights reserved.
//

#import "JXHomePageViewModel.h"
#import "JXArticleModel.h"
#import "JXHomePageCellViewModel.h"
#import "FMDatabaseQueue+Extension.h"

@interface JXHomePageViewModel ()

@property (strong, nonatomic) NSMutableArray *articleViewModels; ///< 这个属性主要存储的是文章的vm，上拉加载的时候追加，下拉刷新的时候清空。防止直接修改dataSource
@property (assign, nonatomic) BOOL isRefresh; ///< 是否是刷新(用于处理数据缓存与dataSource)

@end

@implementation JXHomePageViewModel


#pragma mark - lozy loading

- (NSMutableArray *)articleViewModels {
    
    if (!_articleViewModels) {
        _articleViewModels = [NSMutableArray new];
    }
    return _articleViewModels;
}

// 采用懒加载的方式来配置网络请求
- (RACSignal *)requestSignal {
    
    if (!_requestSignal) {
        
        @weakify(self);
        _requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            @strongify(self);
            
            // 配置网络请求参数
            NSDictionary *parameters = @{@"page": @(self.currentPage)};
            
            
            // 发起请求
            NSURLSessionDataTask *task = [self.sessionManager GET:@"http://www.saitjr.com/api_for_test/static_article_list.php" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                // 可封装为请求正确，但是校验未通过处理
                if ([responseObject[@"code"] integerValue] == RequestErrorCode_NoData) {
                    [subscriber sendNext:nil];
                    [subscriber sendError:GlobalError(GlobalErrorType_Request, @"没数据啦")];
                    return;
                }
                
                
                // 将请求下来的字典->模型
                NSArray *articleArray = responseObject[@"data"];
                for (NSDictionary *articleDictionary in articleArray) {
                    JXArticleModel *articleModel = [JXArticleModel mj_objectWithKeyValues:articleDictionary];
                    // 根据模型，初始化cell的vm
                    JXHomePageCellViewModel *cellViewModel = [[JXHomePageCellViewModel alloc] initWithArticleModel:articleModel];
                    // 将cell的vm存入数组
                    [self.articleViewModels addObject:cellViewModel];
                }
                
                // 完成数据处理后，赋值给dataSource
                self.dataSource = [self.articleViewModels copy];
                
                // 如果是刷新操作，则删除数据库中的旧数据
                // 这里也可以采用存入部分新数据的方式，全部删除可能在效率方面不是很好
                if (self.isRefresh) {
                    [self deleteData];
                }
                
                // 存入新数据
                [self saveData];
                
                [subscriber sendNext:self.dataSource];
                [subscriber sendCompleted];
                
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                
                // 如果网络请求出错，则加载数据库中的旧数据
                [self loadData];
                [subscriber sendNext:self.dataSource];
                [subscriber sendError:GlobalError(GlobalErrorType_Request, @"网络错误")];
            }];
            
            // 在信号量作废时，取消网络请求
            return [RACDisposable disposableWithBlock:^{
                
                [task cancel];
            }];
        }];
    }
    return _requestSignal;
}

- (BOOL)isRefresh {
    
    _isRefresh = self.currentPage == 0;
    
    return _isRefresh;
}




#pragma mark - SQLInterface

- (BOOL)saveData {
    
    // 需要在block中进行修改变量值，所以用__block修饰
    __block BOOL isSuccess = NO;
    
    // 批量操作，选择事务
    [[FMDatabaseQueue shareInstense] inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        for (JXHomePageCellViewModel *cellViewModel in self.dataSource) {
            
            JXArticleModel *articleModel = cellViewModel.articleModel;
            
            // 存储
            isSuccess = [db executeUpdate:saveArticleSQL, articleModel.articleID, articleModel.title, articleModel.subtitle];
            // 如果有失败，则停止，跳出循环
            if (!isSuccess) {
                break;
            }
        }
        // 如果遇到失败，则回滚，存储失败
        if (!isSuccess) {
            *rollback = YES;
            return;
        }
    }];
    
    return isSuccess;
}

- (BOOL)deleteData {
    
    __block BOOL isSuccess = NO;
    
    [[FMDatabaseQueue shareInstense] inDatabase:^(FMDatabase *db) {
        
        isSuccess = [db executeUpdate:deleteArticleSQL];
    }];
    
    return isSuccess;
}

- (void)loadData {
    
    [[FMDatabaseQueue shareInstense] inDatabase:^(FMDatabase *db) {
        
        // 1.读取数据
        FMResultSet *set = [db executeQuery:selectArticleSQL];
        
        // 2.循环读取，直到读完
        while ([set next]) {
            JXArticleModel *article = [JXArticleModel new];
            article.title = [set objectForColumnName:@"title"];
            article.articleID = [set objectForColumnName:@"id"];
            article.subtitle = [set objectForColumnName:@"subtitle"];
            JXHomePageCellViewModel *cellViewModel = [[JXHomePageCellViewModel alloc] initWithArticleModel:article];
            [self.articleViewModels addObject:cellViewModel];
        }
        // 3.关闭结果集
        [set close];
    }];
    // 4.读取完后重新赋值给dataSource
    self.dataSource = [self.articleViewModels copy];
}



@end
