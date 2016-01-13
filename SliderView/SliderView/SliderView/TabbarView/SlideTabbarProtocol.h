//
//  SlideTabbarProtocol.h
//  SliderView
//
//  Created by MyMac on 16/1/13.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SlideTabbarDelegate <NSObject>
- (void)SlideTabbar:(id)sender selectAt:(NSInteger)index;
@end

@protocol SlideTabbarProtocol <NSObject>

@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, readonly) NSInteger tabbarCount;
@property(nonatomic, weak) id<SlideTabbarDelegate> delegate;
- (void)switchingFrom:(NSInteger)fromIndex to:(NSInteger)toIndex percent:(float)percent;

@end
