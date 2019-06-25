//
//  DropdownListView.h
//  Demo
//
//  Created by shutong on 2019/6/25.
//  Copyright © 2019 shutong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DropdownItem;
@interface DropdownListView : UIView
/**
 字体颜色，默认 blackColor
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 字体默认14
 */
@property (nonatomic, strong) UIFont *font;

/**
 数据源
 */
@property (nonatomic, strong) NSArray *dataSource;

/**
 默认选中第一个
 */
@property (nonatomic, assign) NSUInteger selectedIndex;
/**
 默认显示的文本
 */
@property (nonatomic, strong) NSString * defaultText;

/**
 当前选中的DropdownListItem
 */
@property (nonatomic, strong, readonly) DropdownItem *selectedItem;
@end

@interface DropdownItem : NSObject
/**
 自定义初始化方法
 
 @param itemId itemId description
 @param itemName itemName description
 @return return value description
 */
- (instancetype)initWithItemId:(NSString * _Nullable)itemId itemName:(NSString * _Nullable)itemName;
/**
 元素id
 */
@property (nonatomic, copy) NSString * itemId;
/**
 元素名称
 */
@property (nonatomic, copy) NSString * itemName;
@end

NS_ASSUME_NONNULL_END
