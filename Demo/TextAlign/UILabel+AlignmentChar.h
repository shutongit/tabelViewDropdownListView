//
//  UILabel+AlignmentChar.h
//  Demo
//
//  Created by shutong on 2019/6/24.
//  Copyright © 2019 shutong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (AlignmentChar)
    /**
     两端对齐
     */
- (void)textAlignmentLeftAndRight;
    
    /**
     指定Label以最后的冒号对齐的width两端对齐
     
     @param labelWidth labelWidth description
     */
- (void)textAlignmentLeftAndRightWith:(CGFloat)labelWidth;
@end

NS_ASSUME_NONNULL_END
