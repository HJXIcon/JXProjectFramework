//
//  JXArticleModel.h
//  JXProjectFramework
//
//  Created by mac on 17/5/19.
//  Copyright © 2017年 JXIcon. All rights reserved.
//

#import "JXBaseModel.h"

@interface JXArticleModel : JXBaseModel


@property (copy, nonatomic) NSNumber *articleID;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;

@end

