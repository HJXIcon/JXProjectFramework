//
//  UIView+Extension.m
//  JXProjectFramework
//
//  Created by mac on 17/5/19.
//  Copyright © 2017年 JXIcon. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (UIViewController *)viewcontroller{
    UIResponder *next = [self nextResponder];
    
    while (next) {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    }
    return nil;
}

- (UINavigationController *)navigationController{
    UIResponder *next = [self nextResponder];
    while (next) {
        if ([next isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)next;
        }
        next = [next nextResponder];
    }
    return nil;
}

-(UITableView *)viewTableView{
    UIResponder *next = [self nextResponder];
    while (next) {
        if ([next isKindOfClass:[UITableView class]]) {
            return (UITableView *)next;
        }
        next = [next nextResponder];
    }
    return nil;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame= frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}
- (void)alignHorizontal
{
    self.x = (self.superview.width - self.width) * 0.5;
}

- (void)alignVertical
{
    self.y = (self.superview.height - self.height) *0.5;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    
    if (borderWidth < 0) {
        return;
    }
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (BOOL)isShowOnWindow
{
    //主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    //相对于父控件转换之后的rect
    CGRect newRect = [keyWindow convertRect:self.frame fromView:self.superview];
    //主窗口的bounds
    CGRect winBounds = keyWindow.bounds;
    //判断两个坐标系是否有交汇的地方，返回bool值
    BOOL isIntersects =  CGRectIntersectsRect(newRect, winBounds);
    if (self.hidden != YES && self.alpha >0.01 && self.window == keyWindow && isIntersects) {
        return YES;
    }else{
        return NO;
    }
}

- (CGFloat)borderWidth
{
    return self.borderWidth;
}

- (UIColor *)borderColor
{
    return self.borderColor;
    
}

- (CGFloat)cornerRadius
{
    return self.cornerRadius;
}

- (UIViewController *)parentController
{
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}


- (void)addBorderWith:(UIColor *)color{
    //上边框
    CALayer *topLayer = [CALayer layer];
    topLayer.backgroundColor = color.CGColor;
    topLayer.frame = CGRectMake(1, 0, CGRectGetWidth(self.frame) - 2, 1.0);
    [self.layer addSublayer:topLayer];
    
    //左边框
    CALayer *leftLayer = [CALayer layer];
    leftLayer.backgroundColor = color.CGColor;
    leftLayer.frame = CGRectMake(0, 0, 1, CGRectGetHeight(self.frame));
    [self.layer addSublayer:leftLayer];
    
    //右边框
    CALayer *rightLayer = [CALayer layer];
    rightLayer.backgroundColor = color.CGColor;
    rightLayer.frame = CGRectMake(CGRectGetWidth(self.frame)-1, 0, 1.0, CGRectGetHeight(self.frame));
    [self.layer addSublayer:rightLayer];
    
}



@end
