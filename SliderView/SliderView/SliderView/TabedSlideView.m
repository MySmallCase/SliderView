//
//  TabedSlideView.m
//  SliderView
//
//  Created by MyMac on 16/1/13.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import "TabedSlideView.h"
#import "FixedTabbarView.h"
#import "SlideView.h"
#import "LRUCache.h"

#define kDefaultTabbarHeight 44
#define kDefaultTabbarBottomSpacing 0
#define kDefaultCacheCount 4


@implementation TabedbarItem
+ (TabedbarItem *)itemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage{
    TabedbarItem *item = [[TabedbarItem alloc] init];
    item.title = title;
    item.image = image;
    item.selectedImage = selectedImage;
    
    return item;
}

@end

@interface TabedSlideView()<SlideViewDelegate, SlideViewDataSource>

@end



@implementation TabedSlideView {
    SlideView *slideView_;
    FixedTabbarView *tabbar_;
    LRUCache *ctrlCache_;
}


- (void)commonInit{
    self.tabbarHeight = kDefaultTabbarHeight;
    self.tabbarBottomSpacing = kDefaultTabbarBottomSpacing;
    
    tabbar_ = [[FixedTabbarView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.tabbarHeight)];
    tabbar_.delegate = self;
    [self addSubview:tabbar_];
    
    slideView_ = [[SlideView alloc] initWithFrame:CGRectMake(0, self.tabbarHeight+self.tabbarBottomSpacing, self.bounds.size.width, self.bounds.size.height-self.tabbarHeight-self.tabbarBottomSpacing)];
    slideView_.delegate = self;
    slideView_.dataSource = self;
    [self addSubview:slideView_];
    
    ctrlCache_ = [[LRUCache alloc] initWithCount:kDefaultCacheCount];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self layoutBarAndSlide];
}

- (void)layoutBarAndSlide{
    UIView *barView = (UIView *)tabbar_;
    barView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), self.tabbarHeight);
    slideView_.frame = CGRectMake(0, self.tabbarHeight+self.tabbarBottomSpacing, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-self.tabbarHeight-self.tabbarBottomSpacing);
    
}

- (void)setBaseViewController:(UIViewController *)baseViewController{
    slideView_.baseViewController = baseViewController;
}

- (void)buildTabbar{
    NSMutableArray *tabbarItems = [NSMutableArray array];
    for (TabedbarItem *item in self.tabbarItems) {
        FixedTabbarViewTabItem *barItem = [[FixedTabbarViewTabItem alloc] init];
        barItem.title = item.title;
        barItem.titleColor = self.tabItemNormalColor;
        barItem.selectedTitleColor = self.tabItemSelectedColor;
        barItem.image = item.image;
        barItem.selectedImage = item.selectedImage;
        
        [tabbarItems addObject:barItem];
    }
    
    tabbar_.tabbarItems = tabbarItems;
    tabbar_.trackColor = self.tabbarTrackColor;
    tabbar_.backgroundImage = self.tabbarBackgroundImage;
    
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    [slideView_ setSelectedIndex:selectedIndex];
    [tabbar_ setSelectedIndex:selectedIndex];
}

- (void)SlideTabbar:(id)sender selectAt:(NSInteger)index{
    [slideView_ setSelectedIndex:index];
}

- (NSInteger)numberOfControllersInSlideView:(SlideView *)sender{
    return [self.delegate numberOfTabsInTabedSlideView:self];
}

- (UIViewController *)SlideView:(SlideView *)sender controllerAt:(NSInteger)index{
    NSString *key = [NSString stringWithFormat:@"%ld", (long)index];
    if ([ctrlCache_ objectForKey:key]) {
        return [ctrlCache_ objectForKey:key];
    }
    else{
        UIViewController *ctrl = [self.delegate TabedSlideView:self controllerAt:index];
        [ctrlCache_ setObject:ctrl forKey:key];
        return ctrl;
    }
}

- (void)SlideView:(SlideView *)slide switchingFrom:(NSInteger)oldIndex to:(NSInteger)toIndex percent:(float)percent{
    [tabbar_ switchingFrom:oldIndex to:toIndex percent:percent];
}

- (void)SlideView:(SlideView *)slide didSwitchTo:(NSInteger)index{
    [tabbar_ setSelectedIndex:index];
    if (self.delegate && [self.delegate respondsToSelector:@selector(TabedSlideView:didSelectedAt:)]) {
        [self.delegate TabedSlideView:self didSelectedAt:index];
    }
}

- (void)SlideView:(SlideView *)slide switchCanceled:(NSInteger)oldIndex{
    [tabbar_ setSelectedIndex:oldIndex];
}




@end
