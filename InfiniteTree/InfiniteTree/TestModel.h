//
//  TestModel.h
//  TreeCell
//
//  Created by zhouke on 2018/9/11.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfiniteTreeModel.h"

@interface TestModel : NSObject<InfiniteTreeModelDataProtocol>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *items;

@end
