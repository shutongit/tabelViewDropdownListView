//
//  ShowTableViewCell.m
//  Demo
//
//  Created by shutong on 2019/6/25.
//  Copyright © 2019 shutong. All rights reserved.
//

#import "ShowTableViewCell.h"
#import "UILabel+AlignmentChar.h"
#import "DropdownListView.h"

@interface ShowTableViewCell ()
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) DropdownListView *listView;
@end
@implementation ShowTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, self.bounds.size.height)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor cyanColor];
        [_titleLabel textAlignmentLeftAndRight];
        [self.contentView addSubview:_titleLabel];
        
        DropdownListView *view = [[DropdownListView alloc]initWithFrame:self.bounds];
        [self.contentView addSubview:view];
        view.defaultText = @"请选择选项";
        self.listView = view;
        self.listView.block = ^(DropdownListView * _Nonnull view) {
            
        };
        
        
    }
    return self;
}
- (void)layoutSubviews
{
    self.titleLabel.frame = CGRectMake(5, 0, 100, self.contentView.frame.size.height);
    
    self.listView.frame = CGRectMake(110, 0, self.contentView.frame.size.width - 115, self.contentView.frame.size.height);
}
- (void)configureData:(NSArray *)array indexPath:(nonnull NSIndexPath *)indexPath
{
    self.indexPath = indexPath;
    self.titleLabel.text = @"请输入内容：";
    self.listView.dataSource = array;
}

@end
