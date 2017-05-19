//
//  SQL.h
//  JXProjectFramework
//
//  Created by mac on 17/5/19.
//  Copyright © 2017年 JXIcon. All rights reserved.
//

#import <Foundation/Foundation.h>

// 项目中执行的SQL

static NSString * const createArticleSQL = @"CREATE TABLE IF NOT EXISTS article (id INT, title VARCHAR, subtitle VARCHAR)";

static NSString * const saveArticleSQL = @"INSERT INTO article VALUES (?, ?, ?)";
static NSString * const deleteArticleSQL = @"DELETE FROM article";
static NSString * const selectArticleSQL = @"SELECT * FROM article";


