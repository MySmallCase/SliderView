//
//  TabedSlideView.h
//  SliderView
//
//  Created by MyMac on 16/1/13.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideTabbarProtocol.h"

@interface TabedbarItem : NSObject
@property (nonatomic, strong) NSString *title;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) UIImage *selectedImage;

+ (TabedbarItem *)itemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage;
@end

@class TabedSlideView;

@protocol TabedSlideViewDelegate <NSObject>
- (NSInteger)numberOfTabsInTabedSlideView:(TabedSlideView *)sender;
- (UIViewController *)TabedSlideView:(TabedSlideView *)sender controllerAt:(NSInteger)index;
@optional
- (void)TabedSlideView:(TabedSlideView *)sender didSelectedAt:(NSInteger)index;
@end


@interface TabedSlideView : UIView<SlideTabbarDelegate>
@property(nonatomic, weak) UIViewController *baseViewController;
@property(nonatomic, assign) NSInteger selectedIndex;


//set tabbar properties.
@property (nonatomic, strong) UIColor *tabItemNormalColor;
@property (nonatomic, strong) UIColor *tabItemSelectedColor;
@property(nonatomic, strong) UIImage *tabbarBackgroundImage;
@property(nonatomic, strong) UIColor *tabbarTrackColor;
@property(nonatomic, strong) NSArray *tabbarItems;
@property(nonatomic, assign) float tabbarHeight;
@property(nonatomic, assign) float tabbarBottomSpacing;

// cache properties
@property(nonatomic, assign) NSInteger cacheCount;

- (void)buildTabbar;



@property(nonatomic, weak) id<TabedSlideViewDelegate>delegate;

@end
