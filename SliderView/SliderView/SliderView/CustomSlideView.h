//
//  CustomSlideView.h
//  SliderView
//
//  Created by MyMac on 16/1/13.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideTabbarProtocol.h"
#import "SlideView.h"
#import "TabedSlideView.h"
#import "CacheProtocol.h"


@class CustomSlideView;

@protocol CustomSlideViewDelegate <NSObject>
- (NSInteger)numberOfTabsInCustomSlideView:(CustomSlideView *)sender;
- (UIViewController *)CustomSlideView:(CustomSlideView *)sender controllerAt:(NSInteger)index;
@optional
- (void)CustomSlideView:(CustomSlideView *)sender didSelectedAt:(NSInteger)index;
@end


@interface CustomSlideView : UIView<SlideTabbarDelegate, SlideViewDelegate, SlideViewDataSource>
@property(nonatomic, weak) UIViewController *baseViewController;
@property(nonatomic, assign) NSInteger selectedIndex;

// tabbar
@property(nonatomic, strong) UIView<SlideTabbarProtocol> *tabbar;
@property(nonatomic, assign) float tabbarBottomSpacing;

// cache properties
@property(nonatomic, strong) id<CacheProtocol> cache;

// delegate
@property(nonatomic, weak) id<CustomSlideViewDelegate>delegate;

// init method. 初始分方法
- (void)setup;

@end
