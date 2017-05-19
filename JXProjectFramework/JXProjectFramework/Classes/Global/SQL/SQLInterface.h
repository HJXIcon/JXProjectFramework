//
//  SQLInterface.h
//  JXProjectFramework
//
//  Created by mac on 17/5/19.
//  Copyright © 2017年 JXIcon. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 关于 CRUD 方法的定义，借鉴了 Java Interface 的设计：
 */

// 数据缓存统一接口，在需要存储数据的类中遵循协议
@protocol SQLInterface <NSObject>

@optional
- (BOOL)saveData;
- (void)loadData;
- (BOOL)deleteData;
- (BOOL)updateData;

@end
