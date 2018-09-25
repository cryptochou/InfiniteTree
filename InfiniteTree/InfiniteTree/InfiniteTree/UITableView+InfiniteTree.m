//
//  UITableView+InfiniteTree.m
//  TreeCell
//
//  Created by zhouke on 2018/9/13.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "UITableView+InfiniteTree.h"
#import "InfiniteTreeModel.h"

@implementation UITableView (InfiniteTree)

- (void)if_dealSelectAtIndexPath:(NSIndexPath *)indexPath sourceArray:(NSMutableArray *)sourceArray
{
    InfiniteTreeModel *model = sourceArray[indexPath.row];
    if (!model.hasChildren) return;
    
    if (model.isOpen) {
        model.isOpen = NO;
        NSIndexSet *deleteIndexSet = [model qureyTreeModelsWithSource:sourceArray];
        [sourceArray removeObjectsAtIndexes:deleteIndexSet];
        NSArray *deleteIndexPaths = [model getDeleteIndexPathsWithIndexSet:deleteIndexSet];
        [self deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:UITableViewRowAnimationNone];
    } else {
        model.isOpen = YES;
        NSIndexSet *insertIndexSet = [model insertTreeModelsIndexSetWithStartIndex:indexPath.row];
        NSArray *insertModels = [model insertTreeModels];
        [sourceArray insertObjects:insertModels atIndexes:insertIndexSet];
        [self insertRowsAtIndexPaths:[model insertTreeModelsIndexPathsWithStartIndex:indexPath.row] withRowAnimation:UITableViewRowAnimationNone];
    }
    [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
@end
