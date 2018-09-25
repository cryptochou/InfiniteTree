//
//  InfiniteTreeCell.m
//  TreeCell
//
//  Created by zhouke on 2018/9/11.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "InfiniteTreeCell.h"
#import "InfiniteTreeModel.h"

#define k_TAG_BUTTON_WH 15
#define k_TAG_BUTTON_LEADING 15

#define k_TOP_LINE_H 30
#define k_LINE_W 1

@interface InfiniteTreeCell()

@property (strong, nonatomic) UIButton *tagBtn;
@property (strong, nonatomic) UIView *topLineView;
@property (strong, nonatomic) UIView *bottomLineView;

@end

@implementation InfiniteTreeCell

+ (instancetype)infiniteTreeCellWithTableView:(UITableView *)tableView
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self)];
    }
    return (InfiniteTreeCell *)cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.tagBtn];
        [self.contentView addSubview:self.topLineView];
        [self.contentView addSubview:self.bottomLineView];
        [self.contentView addSubview:self.containView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.topLineView.frame = CGRectMake(k_TAG_BUTTON_LEADING + k_TAG_BUTTON_WH / 2, 0, k_LINE_W, k_TOP_LINE_H);
    self.tagBtn.frame = CGRectMake(k_TAG_BUTTON_LEADING, CGRectGetMaxY(self.topLineView.frame), k_TAG_BUTTON_WH, k_TAG_BUTTON_WH);
    self.bottomLineView.frame = CGRectMake(self.topLineView.frame.origin.x, CGRectGetMaxY(self.tagBtn.frame), k_LINE_W, self.frame.size.height - CGRectGetMaxY(self.tagBtn.frame));
    self.containView.frame = CGRectMake(CGRectGetMaxX(self.tagBtn.frame) + k_TAG_BUTTON_LEADING, 0, self.frame.size.width - CGRectGetMaxX(self.tagBtn.frame) + k_TAG_BUTTON_LEADING, self.frame.size.height);
}

- (void)setModel:(InfiniteTreeModel *)model
{
    _model = model;
    
    if (model.hasChildren) {
        self.tagBtn.enabled = YES;
        self.tagBtn.selected = NO;
    } else {
        self.tagBtn.enabled = NO;
        self.tagBtn.selected = NO;
    }
    
    if (!model.parentModel) {
        if (model.isOpen) {
            self.bottomLineView.hidden = NO;
            self.topLineView.hidden = YES;
            self.tagBtn.selected = YES;
            self.tagBtn.enabled = YES;
        } else {
            self.bottomLineView.hidden = YES;
            self.topLineView.hidden = YES;
        }
    } else {
        if (model.isOpen) {
            self.bottomLineView.hidden = NO;
            self.topLineView.hidden = NO;
            self.tagBtn.selected = YES;
            self.tagBtn.enabled = YES;
        } else {
            if (model.isLastDot) {
                self.bottomLineView.hidden = YES;
                self.topLineView.hidden = NO;
            } else {
                self.bottomLineView.hidden = NO;
                self.topLineView.hidden = NO;
            }
        }
    }
}

- (UIButton *)tagBtn
{
    if (!_tagBtn) {
        _tagBtn = [[UIButton alloc] init];
        [_tagBtn setTitle:@"+" forState:UIControlStateNormal];
        [_tagBtn setTitle:@"-" forState:UIControlStateSelected];
        [_tagBtn setTitle:@"·" forState:UIControlStateDisabled];
        _tagBtn.backgroundColor = [UIColor blueColor];
        _tagBtn.layer.cornerRadius = k_TAG_BUTTON_WH / 2;
    }
    return _tagBtn;
}

- (UIView *)topLineView
{
    if (!_topLineView) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = [UIColor blueColor];
    }
    return _topLineView;
}

- (UIView *)bottomLineView
{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor blueColor];
    }
    return _bottomLineView;
}

@end
