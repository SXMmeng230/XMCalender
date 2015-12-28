//
//  NSDate+DateCategory.m
//  XMCalender
//
//  Created by mac on 15/11/13.
//  Copyright © 2015年 yueDi. All rights reserved.
//

#import "NSDate+DateCategory.h"

@implementation NSDate (DateCategory)
- (NSString *)stringForDate
{
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    formate.dateFormat = @"yyyy-MM";
    return [formate stringFromDate:self];
}
- (NSString *)stringForDateFormatDay
{
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    formate.dateFormat = @"yyyy-MM-dd";
    return [formate stringFromDate:self];
}

@end
