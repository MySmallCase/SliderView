//
//  LRUCache.h
//  SliderView
//
//  Created by MyMac on 16/1/13.
//  Copyright © 2016年 MyMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CacheProtocol.h"

@interface LRUCache : NSObject<CacheProtocol>

- (id)initWithCount:(NSInteger)count;

- (void)setObject:(id)object forKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;

@end
