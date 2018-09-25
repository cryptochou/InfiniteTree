//
//  TestModel.m
//  TreeCell
//
//  Created by zhouke on 2018/9/11.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

- (NSArray *)childrenModels
{
    return self.childrens;
}

- (NSString *)identifier
{
    return self.title;
}

@end
