//
//  CustomSlideView.m
//  SliderView
//
//  Created by MyMac on 16/1/13.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import "CustomSlideView.h"

#define kDefaultTabbarBottomSpacing 0
#define kDefaultCacheCount 4

@implementation CustomSlideView {
    SlideView *slideView_;
}

- (void)commonInit{
    self.tabbarBottomSpacing = kDefaultTabbarBottomSpacing;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)setup {
    self.tabbar.delegate = self;
    [self addSubview:self.tabbar];
    
    slideView_ = [[SlideView alloc] initWithFrame:CGRectMake(0, self.tabbar.frame.size.height+self.tabbarBottomSpacing, self.bounds.size.width, self.bounds.size.height-self.tabbar.frame.size.height-self.tabbarBottomSpacing)];
    slideView_.delegate = self;
    slideView_.dataSource = self;
    slideView_.baseViewController = self.baseViewController;
    [self addSubview:slideView_];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self layoutBarAndSlide];
}

- (void)layoutBarAndSlide {
    self.tabbar.frame = CGRectMake(0, 0, CGRectGetWidth(self.tabbar.bounds), self.tabbar.frame.size.height);
    slideView_.frame = CGRectMake(0, self.tabbar.frame.size.height+self.tabbarBottomSpacing, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-self.tabbar.frame.size.height-self.tabbarBottomSpacing);
}

- (void)setBaseViewController:(UIViewController *)baseViewController {
    slideView_.baseViewController = baseViewController;
    _baseViewController = baseViewController;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [slideView_ setSelectedIndex:selectedIndex];
    [self.tabbar setSelectedIndex:selectedIndex];
}

- (void)SlideTabbar:(id)sender selectAt:(NSInteger)index {
    [slideView_ setSelectedIndex:index];
}

- (NSInteger)numberOfControllersInSlideView:(SlideView *)sender {
    return [self.delegate numberOfTabsInCustomSlideView:self];
}

- (UIViewController *)SlideView:(SlideView *)sender controllerAt:(NSInteger)index {
    NSString *key = [NSString stringWithFormat:@"%ld", (long)index];
    if ([self.cache objectForKey:key]) {
        return [self.cache objectForKey:key];
    }
    else{
        UIViewController *ctrl = [self.delegate CustomSlideView:self controllerAt:index];
        [self.cache setObject:ctrl forKey:key];
        return ctrl;
    }
}

- (void)SlideView:(SlideView *)slide switchingFrom:(NSInteger)oldIndex to:(NSInteger)toIndex percent:(float)percent {
    [self.tabbar switchingFrom:oldIndex to:toIndex percent:percent];
}

- (void)SlideView:(SlideView *)slide didSwitchTo:(NSInteger)index {
    [self.tabbar setSelectedIndex:index];
    if (self.delegate && [self.delegate respondsToSelector:@selector(TabedSlideView:didSelectedAt:)]) {
        [self.delegate CustomSlideView:self didSelectedAt:index];
    }
}

- (void)SlideView:(SlideView *)slide switchCanceled:(NSInteger)oldIndex{
    [self.tabbar setSelectedIndex:oldIndex];
}


@end
