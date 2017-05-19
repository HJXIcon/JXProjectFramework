//
//  Define.h
//  JXProjectFramework
//
//  Created by mac on 17/5/19.
//  Copyright © 2017年 JXIcon. All rights reserved.
//

#ifndef Define_h
#define Define_h


// 一些常用方法的宏定义，摘自MVVMReactiveCocoa
#define ST_DOCUMENT_DIRECTORY NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

#define ST_APP_NAME    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])
#define ST_APP_VERSION ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
#define ST_APP_BUILD   ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])


#define kScreenW ([UIScreen mainScreen].bounds.size.width)
#define kScreenH ([UIScreen mainScreen].bounds.size.height)




#endif /* Define_h */
