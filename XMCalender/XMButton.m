//
//  XMButton.m
//  XMCalender
//
//  Created by mac on 15/11/13.
//  Copyright © 2015年 yueDi. All rights reserved.
//

#import "XMButton.h"
#import "NSDate+DateCategory.h"
@implementation XMButton
- (instancetype)initWithFrame:(CGRect)frame isWeek:(BOOL)isWeek
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (isWeek) {
            [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
    }
    return self;
}
- (void)setBtnDate:(NSDate *)btnDate
{
    if (_btnDate != btnDate) {
        _btnDate = btnDate;
    }
    if ([[_btnDate stringForDateFormatDay] isEqualToString:[[NSDate date]stringForDateFormatDay]]) {
        self.backgroundColor = [UIColor blueColor];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
