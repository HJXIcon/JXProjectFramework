//
//  JXHomePageCellViewModel.m
//  JXProjectFramework
//
//  Created by mac on 17/5/19.
//  Copyright © 2017年 JXIcon. All rights reserved.
//

#import "JXHomePageCellViewModel.h"
#import "JXArticleModel.h"

@implementation JXHomePageCellViewModel

- (instancetype)initWithArticleModel:(JXArticleModel *)articleModel {
    
    self = [super init];
    
    if (self) {
        self.articleModel = articleModel;
        [self setupData];
    }
    
    return self;
}

// 处理Model中的数据
// 这里的处理不是很复杂，仅仅作为例子
- (void)setupData {
    _titleText = self.articleModel.title;
    _subtitleText = self.articleModel.subtitle;
    _idText = self.articleModel.articleID.stringValue;
}


@end
