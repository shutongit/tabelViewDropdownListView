//
//  ShowTableViewCell.m
//  Demo
//
//  Created by shutong on 2019/6/25.
//  Copyright © 2019 shutong. All rights reserved.
//

#import "ShowTableViewCell.h"
#import "DropdownListView.h"

@interface ShowTableViewCell ()
@property (nonatomic, strong) DropdownListView *listView;
@end
@implementation ShowTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        DropdownListView *view = [[DropdownListView alloc]initWithFrame:self.bounds];
        [self.contentView addSubview:view];
        view.defaultText = @"请选择选项";
        self.listView = view;
    }
    return self;
}
- (void)layoutSubviews
{
    self.listView.frame = self.contentView.frame;
    self.listView.layer.borderColor = [UIColor greenColor].CGColor;
    self.listView.layer.borderWidth = 1;
}


@end
