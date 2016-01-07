//
//  Person.h
//  NSKeyedArchiver
//
//  Created by GG on 16/1/7.
//  Copyright © 2016年 王立广. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>

@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger age;
@property (nonatomic,copy) NSString *sex;

@end
