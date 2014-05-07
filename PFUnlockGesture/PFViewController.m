//
//  PFViewController.m
//  PFUnlockGesture
//
//  Created by 若水 on 14-5-6.
//  Copyright (c) 2014年 若水. All rights reserved.
//

#import "PFViewController.h"
#import "PFUnlockGestureView.h"

@interface PFViewController ()<PFUnlockGestureViewDelegate>

@end

@implementation PFViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    PFUnlockGestureView *gest = [[PFUnlockGestureView alloc] init];
    gest.delegate = self;
    [gest showInView:self.view];
}

- (void)touchViewTouchSeq:(NSString *)touchSeq{
    NSLog(@"输出序列___%@", touchSeq);
}

@end
