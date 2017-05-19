//
//  JXTabBar.h
//  JXProjectFramework
//
//  Created by mac on 17/5/19.
//  Copyright © 2017年 JXIcon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXTabBar;

@protocol JXTabBarDelegate <NSObject>
@optional
- (void)tabBarPlusBtnClick:(JXTabBar *)tabBar;
@end

@interface JXTabBar : UITabBar

@property (nonatomic, weak) UIButton *plusBtn ;

/** tabbar的代理 */
@property (nonatomic, weak) id<JXTabBarDelegate> myDelegate;

@end
