//
//  ViewController.m
//  XMCalender
//
//  Created by mac on 15/11/13.
//  Copyright © 2015年 yueDi. All rights reserved.
//

#import "ViewController.h"
#import "XMCalenderView.h"

@interface ViewController ()
@property (nonatomic, strong) XMCalenderView *calenderView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.calenderView = [[XMCalenderView alloc] initWithFrame:CGRectMake(20, 200, [UIScreen mainScreen].bounds.size.width - 20, 300)];
    self.calenderView.backgroundColor = [UIColor greenColor];
    self.calenderView.isAutoHeight = YES;
    [self.view addSubview:self.calenderView];
    
}
- (IBAction)clickBtn:(UIButton *)sender {
    [self.calenderView showMonth:XMSwipeGestureDirectionNextMonth];
}
- (IBAction)clickPreBtn:(UIButton *)sender {
    [self.calenderView showMonth:XMSwipeGestureDirectionPreMonth];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
