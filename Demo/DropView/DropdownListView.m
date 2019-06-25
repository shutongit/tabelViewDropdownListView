//
//  DropdownListView.m
//  Demo
//
//  Created by shutong on 2019/6/25.
//  Copyright © 2019 shutong. All rights reserved.
//

#import "DropdownListView.h"

static CGFloat const kArrowImgHeight= 10;
static CGFloat const kArrowImgWidth= 15;
static CGFloat const kTextLabelX = 5;
static CGFloat const kItemCellHeight = 40;

@interface DropdownListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel * textLabel;
@property (nonatomic, strong) UIImageView * arrowImg;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * backgroundView;
@end
@implementation DropdownListView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        [self setupProperty];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setupFrame];
}
#pragma mark ************* tableView datasource *************
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.font = _font;
    cell.textLabel.textColor = _textColor;
    DropdownItem *item = _dataSource[indexPath.row];
    cell.textLabel.text = item.itemName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self selectItemAtIndex:indexPath.row];
    [self removeBackgroundView];
//    if (_selectedBlock) {
//        _selectedBlock(self);
//    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

#pragma mark ************* touch event *************
- (void)tapViewExpand:(UITapGestureRecognizer *)ges
{
    [self rotateArrowImage];
    
    CGFloat tableHeight = _dataSource.count * kItemCellHeight;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.backgroundView];
    [window addSubview:self.tableView];
    
    //获取按钮在屏幕中的位置
    CGRect frame = [self convertRect:self.bounds toView:window];
    CGFloat tableY = frame.origin.y + frame.size.height;
    
    CGRect tableFrame;
    tableFrame.size.width = frame.size.width;
    tableFrame.size.height = tableHeight;
    tableFrame.origin.x = frame.origin.x;
    
    if (tableY + tableHeight < CGRectGetHeight([UIScreen mainScreen].bounds)) {
        tableFrame.origin.y = tableY;
    } else {
        tableFrame.origin.y = frame.origin.y - tableHeight;
    }
    _tableView.frame = tableFrame;
    
    UITapGestureRecognizer *tagBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewDismiss:)];
    [_backgroundView addGestureRecognizer:tagBackground];
    
}
-(void)tapViewDismiss:(UITapGestureRecognizer *)sender {
    [self removeBackgroundView];
}
- (void)removeBackgroundView {
    [_backgroundView removeFromSuperview];
    [_tableView removeFromSuperview];
    [self rotateArrowImage];
}
#pragma mark ************* private method *************
/**
 旋转图片
 */
- (void)rotateArrowImage
{
    _arrowImg.transform = CGAffineTransformRotate(_arrowImg.transform, M_PI);
}

#pragma mark ************* 添加视图 *************
- (void)setupView
{
    [self addSubview:self.textLabel];
    [self addSubview:self.arrowImg];
    
    UITapGestureRecognizer *tapLabel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewExpand:)];
    [_textLabel addGestureRecognizer:tapLabel];
    
    UITapGestureRecognizer *tapImg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapViewExpand:)];
    [_arrowImg addGestureRecognizer:tapImg];
}
#pragma mark ************* 配置基本属性 *************
- (void)setupProperty
{
    _textColor = [UIColor blackColor];
    _font = [UIFont systemFontOfSize:14];
    _textLabel.font = _font;
    _textLabel.textColor = _textColor;
}

#pragma mark ************* 更新视图frame *************
- (void)setupFrame
{
    CGFloat viewWidth = CGRectGetWidth(self.bounds);
    CGFloat viewHeight = CGRectGetHeight(self.bounds);
    _textLabel.frame = CGRectMake(kTextLabelX, 0, viewWidth - kTextLabelX - kArrowImgWidth, viewHeight);
    _arrowImg.frame = CGRectMake(CGRectGetWidth(_textLabel.frame), viewHeight / 2 - kArrowImgHeight / 2, kArrowImgWidth, kArrowImgHeight);
}

#pragma mark ************* setter *************
- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    _textLabel.textColor = textColor;
}
- (void)setFont:(UIFont *)font
{
    _font = font;
    _textLabel.font = font;
}
- (void)setDefaultText:(NSString *)defaultText
{
    _defaultText = defaultText;
    if (_selectedIndex > 0) {
    } else {
        _textLabel.text = defaultText;
    }
}
- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    if (dataSource.count > 0) {
        [self selectItemAtIndex:_selectedIndex];
    }
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [self selectItemAtIndex:selectedIndex];
}
- (void)selectItemAtIndex:(NSInteger)index
{
    _selectedIndex = index;
    if (_dataSource.count > index && index > 0) {
        DropdownItem *item = _dataSource[index];
        _selectedItem = item;
        _textLabel.text = item.itemName;
        [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

#pragma mark ************* lazy load *************
- (UILabel*)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.userInteractionEnabled = YES;
    }
    return _textLabel;
}
- (UIImageView*)arrowImg {
    if (!_arrowImg) {
        _arrowImg = [UIImageView new];
        _arrowImg.image = [UIImage imageNamed:@"dropdownFlag"];
        _arrowImg.userInteractionEnabled = YES;
    }
    return _arrowImg;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.layer.shadowOffset = CGSizeMake(4, 4);
        _tableView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _tableView.layer.shadowOpacity = 0.8;
        _tableView.layer.shadowRadius = 4;
        _tableView.layer.borderColor = [UIColor grayColor].CGColor;
        _tableView.layer.borderWidth = 0.5;
        _tableView.clipsToBounds = NO;
        _tableView.rowHeight = kItemCellHeight;
    }
    return _tableView;
}
- (UIView*)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _backgroundView;
}
@end


@implementation DropdownItem

- (instancetype)init
{
    return [self initWithItemId:nil itemName:nil];
}
- (instancetype)initWithItemId:( NSString * _Nullable)itemId itemName:( NSString * _Nullable)itemName
{
    self = [super init];
    if (self) {
        self.itemId = itemId;
        self.itemName = itemName;
    }
    return self;
}

@end
