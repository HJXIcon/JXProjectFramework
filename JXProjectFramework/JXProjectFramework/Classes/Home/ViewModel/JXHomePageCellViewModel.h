//
//  JXHomePageCellViewModel.h
//  JXProjectFramework
//
//  Created by mac on 17/5/19.
//  Copyright © 2017年 JXIcon. All rights reserved.
//

#import "JXBaseViewModel.h"
@class JXArticleModel;

// cell的vm
// 无需网络请求，所以继承BaseViewModel即可
@interface JXHomePageCellViewModel : JXBaseViewModel


@property (strong, nonatomic) JXArticleModel *articleModel;

@property (copy, nonatomic, readonly) NSString *titleText;
@property (copy, nonatomic, readonly) NSString *subtitleText;
@property (copy, nonatomic, readonly) NSString *idText;

- (instancetype)initWithArticleModel:(JXArticleModel *)articleModel;

@end
