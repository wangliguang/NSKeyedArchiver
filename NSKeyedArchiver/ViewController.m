//
//  ViewController.m
//  NSKeyedArchiver
//
//  Created by GG on 16/1/7.
//  Copyright © 2016年 王立广. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
@interface ViewController ()
{
    //要归档的路径
    NSString *path;
}
@end

@implementation ViewController

#pragma 对单个对象归档与解归档
/*
- (void)viewDidLoad {
    [super viewDidLoad];
    
    path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingString:@"/data.archiver"];
    
    //归档
    [self archiverName:@"小闪" WithAge:@22];
    
    //解归档
    [self unarchiver];
    
}

- (void)archiverName:(NSString *)name WithAge:(NSNumber *)age {
    
    [NSKeyedArchiver archiveRootObject:name toFile:path];
    
    [NSKeyedArchiver archiveRootObject:age toFile:path];

}

- (void)unarchiver{
    
    //上面我对name和age都归档进同一个路径，但此时只能取出我最后归档的对象，也就是说采用这种方式归档，如果在同一路径下，只能对同一个对象进行归档，后面归档的对象会覆盖上次归档的对象。
    id content = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"%@",content);
}
*/

#pragma 对自定义的类的单个对象创建的对象归档与解归档
/*
- (void)viewDidLoad{
    [super viewDidLoad];
    
    path =     path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingString:@"/data.archiver"];

    Person *person = [Person new];
    
    person.name = @"小闪";
    person.age = 22;
    person.sex = @"女";
    
    //归档
    [NSKeyedArchiver archiveRootObject:person toFile:path];
    
    //解归档
    Person *getPerson = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    NSLog(@"名字=%@，年龄=%ld,性别=%@",getPerson.name,getPerson.age,getPerson.sex);
 
}
*/

#pragma 同时将多个的对象归档与解归档
- (void)viewDidLoad{
    [super viewDidLoad];
    
    path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    path = [path stringByAppendingString:@"/data.archiver"];
    
    NSString *name = @"小闪";
    NSInteger age = 22;
    NSString *sex = @"女";
    
    //归档
    [self archiverData:name WithAge:age WithSex:sex];
    
    //解归档
    [self unarchiverData];
    
}

- (void)archiverData:(NSString *)name WithAge:(NSInteger)age WithSex:(NSString *)sex{
    
    //准备一个可变的data对象，通过归档对象将多个数据存在一个data对象里，最终将这个data写入文件
    NSMutableData *data = [NSMutableData data];
    
    //archiver初始化的时候包装一个可变的data对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    
    //通过归档对象将这些数据转化成二进制，并保存在一个data对象里。
    [archiver encodeObject:name forKey:@"name"];
    [archiver encodeInteger:age forKey:@"age"];
    [archiver encodeObject:sex forKey:@"sex"];
    
    //转化完毕
    [archiver finishEncoding];
    
    //atomically指的是原子性。如果YES，表明数据要么完整的写入文件，要么一点也不写入文件。例如：如果正在存储数据，软件奔溃或者来电话了，数据就一点也不会写入文件。
    [data writeToFile:path atomically:YES];
    
}

- (void)unarchiverData{
    
    //将路径里的二进制数据给取出来
    NSMutableData *data = [NSMutableData dataWithContentsOfFile:path];
    
    //将二进制数据包装在一个解归档对象中
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    
    //通过解归档对象将二进制数据分别给反序列化
    NSString *name = [unarchiver decodeObjectForKey:@"name"];
    NSInteger age = [unarchiver decodeIntegerForKey:@"age"];
    NSString *sex = [unarchiver decodeObjectForKey:@"sex"];
    
    NSLog(@"名字=%@，年龄=%ld，性别=%@",name,age,sex);
}

@end
