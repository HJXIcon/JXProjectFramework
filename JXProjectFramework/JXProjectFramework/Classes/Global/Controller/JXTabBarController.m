//
//  JXTabBarController.m
//  JXProjectFramework
//
//  Created by mac on 17/5/19.
//  Copyright © 2017年 JXIcon. All rights reserved.
//

#import "JXTabBarController.h"
#import "JXTabBar.h"
#import "JXHomeViewController.h"
#import "JXChatViewController.h"
#import "JXMoreViewController.h"
#import "JXDiscoverViewController.h"
#import "JXShopViewController.h"
#import "JXNavigationController.h"

@interface JXTabBarController ()<JXTabBarDelegate>


@end

@implementation JXTabBarController


#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize
{
    
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    
    dictSelected[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#31b2f4"];
    
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpAllChildVc];
    
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    JXTabBar *tabbar = [[JXTabBar alloc] init];
    tabbar.delegate = self;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];
    
}




- (void)setUpAllChildVc
{
    NSString * homeImageName = @"home_home_select";
    NSString * charImageName = @"home_chat_select";
    NSString * mallImageName = @"home_shop_select";
    NSString * foundImageName = @"home_find_select";
    
    JXHomeViewController *HomeVC = [[JXHomeViewController alloc] init];
    [self setUpOneChildVcWithVc:HomeVC Image:@"home_home_unselect" selectedImage:homeImageName title:@"主页"];
    
    JXChatViewController *chatVC = [[JXChatViewController alloc] init];
    
    [self setUpOneChildVcWithVc:chatVC Image:@"home_chat_unselect" selectedImage:charImageName title:@"聊天"];
    
    JXShopViewController *shopVC = [[JXShopViewController alloc] init];
    [self setUpOneChildVcWithVc:shopVC Image:@"home_shop_unselect" selectedImage:mallImageName title:@"商城"];
    
    JXDiscoverViewController *yujudianVC = [[JXDiscoverViewController alloc] init];
    [self setUpOneChildVcWithVc:yujudianVC Image:@"home_find_unselect" selectedImage:foundImageName title:@"发现"];
    
}


#pragma mark - 初始化设置tabBar上面单个按钮的方法
/**
 *  @author li bo, 16/05/10
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    JXNavigationController *nav = [[JXNavigationController alloc] initWithRootViewController:Vc];
    
    
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;
    
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    Vc.tabBarItem.selectedImage = mySelectedImage;
    
    Vc.tabBarItem.title = title;
    
   
    Vc.navigationItem.title = title;
        
    
    [self addChildViewController:nav];
}


#pragma mark - JXTabBarDelegate

- (void)tabBarPlusBtnClick:(JXTabBar *)tabBar{
    
}
@end
