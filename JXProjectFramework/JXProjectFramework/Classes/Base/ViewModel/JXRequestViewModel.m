//
//  JXRequestViewModel.m
//  JXProjectFramework
//
//  Created by mac on 17/5/19.
//  Copyright © 2017年 JXIcon. All rights reserved.
//

#import "JXRequestViewModel.h"

@implementation JXRequestViewModel
// 懒加载
- (AFHTTPSessionManager *)sessionManager {
    
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        _sessionManager.requestSerializer.timeoutInterval = 30;
    }
    return _sessionManager;
    
}

// 在对象销毁时，别忘了取消已经在队列中的请求
- (void)dealloc {
    
    [self.sessionManager invalidateSessionCancelingTasks:YES];
}


@end
