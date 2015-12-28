//
//  XMCalenderView.m
//  XMCalender
//
//  Created by mac on 15/11/13.
//  Copyright © 2015年 yueDi. All rights reserved.
//

#import "XMCalenderView.h"
#import "XMButton.h"
#import "NSDate+DateCategory.h"

#define kOffset_Btn 5
#define kCalendarBtnHeight 40
#define kClaendarLableHeight 30
@interface XMCalenderView()
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, assign) NSCalendarUnit currentUnit;
@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, strong) UILabel *showDateLabel;
@property (nonatomic, strong) UIButton *seletectdBtn;
@end

@implementation XMCalenderView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initCalender];
    }
    return self;
}
- (void)initCalender
{
    self.calendar = [NSCalendar currentCalendar];
    self.currentUnit = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay;
    self.currentDate = [NSDate date];
    self.isAutoHeight = NO;
    self.isSwipe = YES;
    [self initBtnForDate:self.currentDate];
    [self initLabel];
}
- (void)initLabel
{
    self.showDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 100, 0, 200, 30)];
    self.showDateLabel.text = [self.currentDate stringForDate];
    self.showDateLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.showDateLabel];
    NSArray *arr = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    CGFloat width = self.frame.size.width / arr.count;
    for (int i = 0 ; i < arr.count; i ++ ) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * width, self.showDateLabel.frame.size.height, width, 30)];
        label.text = arr[i];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
}
- (void)initBtnForDate:(NSDate *)btnDate
{
    NSDateComponents *component = [self.calendar components:self.currentUnit fromDate:btnDate];
    component.day = 1;
    NSDate *firstDate = [self.calendar dateFromComponents:component];
    NSDateComponents *firstCom = [self.calendar components:NSCalendarUnitWeekday fromDate:firstDate];
    NSInteger week =  firstCom.weekday;
    
    NSRange days = [self.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:btnDate];
    NSInteger monthLength = days.length;
    CGFloat width = (self.frame.size.width - 8 * kOffset_Btn) / 7;
   
    CGFloat heightSelf = 0.0;
    for (int i = 0; i < monthLength; i ++ ) {
        if ( i != 0) {
            component.day += 1;
        }
        CGFloat offWidth = (width + kOffset_Btn) * ((week - 1 + i)%7) + kOffset_Btn;
        CGFloat offHeight = (kCalendarBtnHeight + kOffset_Btn) * ((i + week - 1)/7);
        BOOL isWeek = NO;
        if ((week - 1 + i) % 7 == 6 || ((week - 1 + i) % 7 == 0)) {
            isWeek = YES;
        }
        XMButton *btn = [[XMButton alloc] initWithFrame:CGRectMake(offWidth,kClaendarLableHeight + kOffset_Btn + 30 + offHeight, width, kCalendarBtnHeight) isWeek:isWeek];
        btn.btnDate = [self.calendar dateFromComponents:component];
        NSString *titel = [NSString stringWithFormat:@"%ld",(long)component.day];
        [btn setTitle:titel forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        heightSelf = btn.frame.origin.y + btn.frame.size.height + 10;
    }
    if (self.isAutoHeight) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, heightSelf);
    }
}
- (void)setIsAutoHeight:(BOOL)isAutoHeight
{
    if (_isAutoHeight != isAutoHeight) {
        _isAutoHeight = isAutoHeight;
    }
    [self removeAllBtn];
    [self initBtnForDate:self.currentDate];
}
- (void)setIsSwipe:(BOOL)isSwipe
{
    if (_isSwipe != isSwipe) {
        _isSwipe = isSwipe;
    }
    if (_isSwipe) {
        UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
        self.userInteractionEnabled = YES;
        leftSwipe.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:leftSwipe];
        
        UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
        rightSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:rightSwipe];
    }else{
        for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
            [self removeGestureRecognizer:gesture];
        }
    }
}
- (void)clickBtn:(XMButton *)btn
{
    self.seletectdBtn.backgroundColor = [UIColor whiteColor];
    btn.backgroundColor = [UIColor yellowColor];
    self.seletectdBtn = btn;
    self.showDateLabel.text = [btn.btnDate stringForDateFormatDay];
}
- (void)swipeLeft:(UISwipeGestureRecognizer *)left
{
    if (left.direction == UISwipeGestureRecognizerDirectionRight) {
        [self showMonth:XMSwipeGestureDirectionPreMonth];
    }else{
        [self showMonth:XMSwipeGestureDirectionNextMonth];
    }
}
- (void)showMonth:(XMSwipeGestureDirection)direction
{
    NSDateComponents *preComponent = [self.calendar components:self.currentUnit fromDate:self.currentDate];
    if (direction == XMSwipeGestureDirectionNextMonth) {
        preComponent.month ++;
    }else if(direction == XMSwipeGestureDirectionPreMonth){
        preComponent.month --;
    }
    NSDate *preDate = [self.calendar dateFromComponents:preComponent];
    [self removeAllBtn];
    [self initBtnForDate:preDate];
    self.currentDate = preDate;
    self.showDateLabel.text = [self.currentDate stringForDate];
}
- (void)removeAllBtn
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
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
