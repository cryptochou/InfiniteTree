//
//  TestCell.m
//  TreeCell
//
//  Created by zhouke on 2018/9/11.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "TestCell.h"
#import "TestModel.h"

@interface TestCell()

@end

@implementation TestCell

- (void)setModel:(InfiniteTreeModel *)model
{
    [super setModel:model];
    
    TestModel *testModel = model.dataModel;
    self.titleLab.text = testModel.title;
}

- (UIView *)contaionView
{
    return self.titleLab;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
    }
    return _titleLab;
}

@end
