//
//  ViewController.m
//  SliderView
//
//  Created by MyMac on 15/10/4.
//  Copyright © 2015年 MyMac. All rights reserved.
//

#import "ViewController.h"
#import "TabedSlideView.h"
#import "FixedTabbarView.h"

#import "View1Controller.h"
#import "View2Controller.h"
#import "View3Controller.h"

@interface ViewController ()<TabedSlideViewDelegate>

@property (nonatomic,strong) TabedSlideView *tabedSlideView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TabedSlideView *tabedSlideView = [[TabedSlideView alloc] init];
    tabedSlideView.frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:tabedSlideView];
    self.tabedSlideView = tabedSlideView;

    self.tabedSlideView.delegate = self;
    self.tabedSlideView.baseViewController = self;

    self.tabedSlideView.tabItemNormalColor = [UIColor blackColor];
    self.tabedSlideView.tabItemSelectedColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarTrackColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarBackgroundImage = [UIImage imageNamed:@"tabbarBk"];

    TabedbarItem *item1 = [TabedbarItem itemWithTitle:@"最新" image:nil selectedImage:nil];
    TabedbarItem *item2 = [TabedbarItem itemWithTitle:@"最热" image:nil selectedImage:nil];
    TabedbarItem *item3 = [TabedbarItem itemWithTitle:@"价格" image:nil selectedImage:nil];
    self.tabedSlideView.tabbarItems = @[item1, item2, item3];
    [self.tabedSlideView buildTabbar];
    self.tabedSlideView.selectedIndex = 0;
    
    
}

- (NSInteger)numberOfTabsInTabedSlideView:(TabedSlideView *)sender{
    return self.tabedSlideView.tabbarItems.count;
}

- (UIViewController *)TabedSlideView:(TabedSlideView *)sender controllerAt:(NSInteger)index{
    switch (index) {
        case 0:
        {
            View1Controller *ctrl = [[View1Controller alloc] init];
            return ctrl;
        }
        case 1:
        {
            View2Controller *ctrl = [[View2Controller alloc] init];
            return ctrl;
        }
        case 2:
        {
            View3Controller *ctrl = [[View3Controller alloc] init];
            return ctrl;
        }
            
        default:
            return nil;
    }
}



@end
