//
//  JXRequestViewModel.h
//  JXProjectFramework
//
//  Created by mac on 17/5/19.
//  Copyright © 2017年 JXIcon. All rights reserved.
//

#import "JXBaseViewModel.h"
#import <AFNetworking/AFNetworking.h>


typedef NS_ENUM(NSInteger, RequestErrorCode) {
    RequestErrorCode_None,
    RequestErrorCode_ParameterError = 1, ///< 参数错误
    RequestErrorCode_LoginRequired = 2, ///< 用户未登录
    RequestErrorCode_NoData = 3 ///< 暂无数据
};

// 继承自BaseViewModel
// 需要网络请求的VM继承该类
// 该类有一个公共属性sessionManager，一个该属性的懒加载方法和一个dealloc中取消网络请求的方法

@interface JXRequestViewModel : JXBaseViewModel

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;


@end
