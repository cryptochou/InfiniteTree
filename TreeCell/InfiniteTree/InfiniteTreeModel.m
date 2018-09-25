//
//  InfiniteTreeModel.m
//  TreeCell
//
//  Created by zhouke on 2018/9/11.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "InfiniteTreeModel.h"
#import <UIKit/UIKit.h>

@implementation InfiniteTreeModel

+ (NSArray <InfiniteTreeModel *>*)infiniteTreeModelArrayWithDataModels:(NSArray<id<InfiniteTreeModelDataProtocol>> *)dataModels
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < dataModels.count; i++) {
        InfiniteTreeModel *model = [[InfiniteTreeModel alloc] init];
        model.dataModel = dataModels[i];
        if (i == dataModels.count - 1) {
            model.isLastDot = YES;
        }
        [array addObject:model];
    }
    return array;
}

- (BOOL)hasChildren
{
    return [self.dataModel childrenModels].count;
}

- (NSArray <InfiniteTreeModel *>*)insertTreeModels
{
    if (!self.hasChildren) return nil;
    
    NSMutableArray *array = [NSMutableArray array];
    NSInteger count = self.dataModel.childrenModels.count;
    for (int i = 0; i < count; i++) {
        InfiniteTreeModel *model = [[InfiniteTreeModel alloc] init];
        model.dataModel = self.dataModel.childrenModels[i];
        model.parentModel = self;
        if (i == count - 1) {
            if (self.isLastDot) {
                model.isLastDot = YES;
            } else if (model.parentModel && !model.parentModel.parentModel) {
                model.isLastDot = YES;
            }
        }
        [array addObject:model];
    }
    return array;
}

- (NSIndexSet *)insertTreeModelsIndexSetWithStartIndex:(NSInteger)startIndex
{
    NSMutableIndexSet *set = [NSMutableIndexSet indexSet];
    NSInteger count = self.dataModel.childrenModels.count;
    for (int i = 0; i < count; i++) {
        [set addIndex:startIndex + i + 1];
    }
    return set;
}

- (NSArray *)insertTreeModelsIndexPathsWithStartIndex:(NSInteger)startIndex
{
    NSMutableArray *array = [NSMutableArray array];
    NSInteger count = self.dataModel.childrenModels.count;
    for (int i = 0; i < count; i++) {
        [array addObject:[NSIndexPath indexPathForRow:startIndex + i + 1 inSection:0]];
    }
    return array;
}

- (NSIndexSet *)qureyTreeModelsWithSource:(NSArray<InfiniteTreeModel*>*)source
{
    if (!self.hasChildren) return [NSIndexSet indexSet];
    
    NSMutableIndexSet *set = [NSMutableIndexSet indexSet];

    NSInteger count = source.count;
    for (int i = 0; i < count; i++) {
        InfiniteTreeModel *model = source[i];
        if ([[self.dataModel identifier] isEqualToString:[model.parentModel.dataModel identifier]]) {
            [set addIndex:i];
            [set addIndexes:[model qureyTreeModelsWithSource:source]];
        } else {
            continue;
        }
    }
    return set;
}

- (NSArray *)getDeleteIndexPathsWithIndexSet:(NSIndexSet *)indexSet
{
    NSMutableArray *array = [NSMutableArray array];
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
    }];
    return array;
}

@end
