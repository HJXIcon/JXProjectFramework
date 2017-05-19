//
//  JXHomePageCell.h
//  JXProjectFramework
//
//  Created by mac on 17/5/19.
//  Copyright © 2017年 JXIcon. All rights reserved.
//

#import "JXBaseTableViewCell.h"
@class JXHomePageCellViewModel;

static NSString * const HomeCellIdentifier = @"HomeIdentifier";

@interface JXHomePageCell : JXBaseTableViewCell

// cell的VM
@property (strong, nonatomic) JXHomePageCellViewModel *viewModel;

+ (CGFloat)getCellHeight;
@end
