//
//  ScrollTabbarView.h
//  SliderView
//
//  Created by MyMac on 16/1/13.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideTabbarProtocol.h"

@interface ScrollTabbarItem : NSObject
@property(nonatomic, strong) NSString *title;
@property(nonatomic, assign) CGFloat width;
+ (ScrollTabbarItem *)itemWithTitle:(NSString *)title width:(CGFloat)width;
@end

@interface ScrollTabbarView : UIView<SlideTabbarProtocol>
@property(nonatomic, strong) UIView *backgroundView;

// tabbar属性
@property (nonatomic, strong) UIColor *tabItemNormalColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *tabItemSelectedColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat tabItemNormalFontSize;
@property(nonatomic, strong) UIColor *trackColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) NSArray *tabbarItems;

// SlideTabbarProtocol
@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, readonly) NSInteger tabbarCount;
@property(nonatomic, weak) id<SlideTabbarDelegate> delegate;
- (void)switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(float)percent;

@end
