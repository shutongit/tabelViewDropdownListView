//
//  ShowTableViewCell.h
//  Demo
//
//  Created by shutong on 2019/6/25.
//  Copyright © 2019 shutong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface ShowTableViewCell : UITableViewCell
/**
 当前视图下标
 */
@property (nonatomic, strong) NSIndexPath * indexPath;
/**
 配置数据

 @param array array description
 */
- (void)configureData:(NSArray *)array indexPath:(NSIndexPath * _Nonnull)indexPath;
@end

NS_ASSUME_NONNULL_END
