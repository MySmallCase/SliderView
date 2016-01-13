//
//  SlideView.h
//  SliderView
//
//  Created by MyMac on 16/1/13.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SlideView;

@protocol SlideViewDataSource <NSObject>
- (NSInteger)numberOfControllersInSlideView:(SlideView *)sender;
- (UIViewController *)SlideView:(SlideView *)sender controllerAt:(NSInteger)index;
@end

@protocol SlideViewDelegate <NSObject>
@optional
- (void)SlideView:(SlideView *)slide switchingFrom:(NSInteger)oldIndex to:(NSInteger)toIndex percent:(float)percent;
- (void)SlideView:(SlideView *)slide didSwitchTo:(NSInteger)index;
- (void)SlideView:(SlideView *)slide switchCanceled:(NSInteger)oldIndex;
@end

@interface SlideView : UIView

@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, weak) UIViewController *baseViewController;
@property(nonatomic, weak) id<SlideViewDelegate>delegate;
@property(nonatomic, weak) id<SlideViewDataSource>dataSource;
- (void)switchTo:(NSInteger)index;

@end
