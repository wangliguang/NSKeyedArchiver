//
//  Person.m
//  NSKeyedArchiver
//
//  Created by GG on 16/1/7.
//  Copyright © 2016年 王立广. All rights reserved.
//

#import "Person.h"

@implementation Person

//被归档的时候会调用这个方法，aCoder就是归档时传过来的归档对象
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
}

//解归档的时候会调用这个方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    //解归档时会产生一个Person对象，这里是给这个Person对象赋值
    self = [super init];
    if (self) {
        
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
    }
    return self;
}

@end
