//
//  InfiniteTreeCell.h
//  TreeCell
//
//  Created by zhouke on 2018/9/11.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InfiniteTreeModel;

@interface InfiniteTreeCell : UITableViewCell

@property (strong, nonatomic) UIView *contaionView;

@property (nonatomic, strong) InfiniteTreeModel *model;

+ (instancetype)infiniteTreeCellWithTableView:(UITableView *)tableView;

@end
