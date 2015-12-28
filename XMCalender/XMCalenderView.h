//
//  XMCalenderView.h
//  XMCalender
//
//  Created by mac on 15/11/13.
//  Copyright © 2015年 yueDi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    XMSwipeGestureDirectionPreMonth = 0,//前一个月
    XMSwipeGestureDirectionNextMonth,//后一个月
} XMSwipeGestureDirection;

@interface XMCalenderView : UIView
//日历是否自适应高度 默认是No
@property (nonatomic, assign) BOOL isAutoHeight;
//是否允许左右滑动来切换月份 默认是YES
@property (nonatomic, assign) BOOL isSwipe;
//切换月份方法
- (void)showMonth:(XMSwipeGestureDirection)direction;
@end
