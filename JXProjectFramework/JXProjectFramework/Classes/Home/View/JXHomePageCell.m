//
//  JXHomePageCell.m
//  JXProjectFramework
//
//  Created by mac on 17/5/19.
//  Copyright © 2017年 JXIcon. All rights reserved.
//

#import "JXHomePageCell.h"
#import "JXHomePageCellViewModel.h"

@implementation JXHomePageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        [self setupSignal];
       
    }
    return self;
}


// 设置信号量，当cell的vm被重新赋值时，更新cell显示的数据
- (void)setupSignal {
    
    @weakify(self);
    [RACObserve(self, viewModel) subscribeNext:^(JXHomePageCellViewModel *viewModel) {
        
        // 使用strong修饰self，防止在self在使用中被释放
        @strongify(self);
        
        // vm已经将要显示的文本处理好了，在cell中直接赋值就行
        self.textLabel.text = viewModel.titleText;
        self.detailTextLabel.text = viewModel.subtitleText;
    }];
}

+ (CGFloat)getCellHeight{
 
    return 60;
}



@end
