//
//  InfiniteTreeModel.h
//  TreeCell
//
//  Created by zhouke on 2018/9/11.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol InfiniteTreeModelDataProtocol <NSObject>

@required;
- (NSArray *)childrenModels;
// 用于比较
- (NSString *)identifier;

@end

@interface InfiniteTreeModel : NSObject

// 当前节点是否展开
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) BOOL isLastDot;
@property (nonatomic, weak) InfiniteTreeModel *parentModel;

@property (nonatomic, assign) BOOL hasChildren;
@property (nonatomic, strong) id<InfiniteTreeModelDataProtocol> dataModel;

+ (NSArray <InfiniteTreeModel *>*)infiniteTreeModelArrayWithDataModels:(NSArray<id<InfiniteTreeModelDataProtocol>> *)dataModels;

- (NSArray <InfiniteTreeModel *>*)insertTreeModels;
- (NSArray *)insertTreeModelsIndexPathsWithStartIndex:(NSInteger)startIndex;
- (NSIndexSet *)insertTreeModelsIndexSetWithStartIndex:(NSInteger)startIndex;

- (NSIndexSet *)qureyTreeModelsWithSource:(NSArray<InfiniteTreeModel*>*)source;
- (NSArray *)getDeleteIndexPathsWithIndexSet:(NSIndexSet *)indexSet;

@end
