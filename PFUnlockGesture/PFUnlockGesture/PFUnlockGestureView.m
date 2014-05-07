//
//  PFUnlockGestureView.m
//  PFUnlockGesture
//
//  Created by 若水 on 14-5-6.
//  Copyright (c) 2014年 若水. All rights reserved.
//

//默认按钮数量
#define kDefaultButtonsMax 9

//按钮的宽度和高度
#define kButtonW 70
#define kButtonH 70

#define kDefaultButtonRowCount 3
#define kDefaultContentViewWH 290

#import "PFUnlockGestureView.h"
#import "PFTouchView.h"

@interface PFUnlockGestureView()<PFTouchViewDelegate>
{
    PFTouchView *_touchView;
}
/**最大的按钮数量*/
@property (nonatomic, assign) NSUInteger buttonsMax;
/**每一行的个数*/
@property (nonatomic, assign) NSUInteger buttonRowCount;

@end

@implementation PFUnlockGestureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _touchView = [[PFTouchView alloc] init];
        _touchView.backgroundColor = [UIColor clearColor];
        _touchView.delegate = self;
        [self addSubview:_touchView];
        //初始化一些参数
        self.buttonsMax = kDefaultButtonsMax;
        self.buttonRowCount = kDefaultButtonRowCount;
        self.contentViewWH = kDefaultContentViewWH;
    }
    return self;
}

- (void)touchViewTouchSeq:(NSString *)touchSeq{
    if ([_delegate respondsToSelector:@selector(touchViewTouchSeq:)]) {
        [_delegate touchViewTouchSeq:touchSeq];
    }
}

- (void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    _touchView.lineColor = lineColor;
}

- (void)setLineWidth:(CGFloat)lineWidth{
    _lineWidth = lineWidth;
    _touchView.lineWidth = lineWidth;
}

- (void)showInView:(UIView *)view{
    if (view == nil) {
        self.frame = [UIApplication sharedApplication].keyWindow.frame;
    }else{
        self.frame = view.bounds;
    }
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gesture_background"]];
    [view addSubview:self];
}

- (void)layoutSubviews{
    CGFloat touchViewWH = self.contentViewWH;
    CGFloat marginX = (touchViewWH - self.buttonRowCount * kButtonW) / (self.buttonRowCount - 1);
    CGFloat marginY = (touchViewWH - self.buttonRowCount * kButtonH) / (self.buttonRowCount - 1);
    CGFloat touchY = (self.superview.frame.size.height - touchViewWH) * 0.5;
    _touchView.frame = CGRectMake((self.superview.frame.size.width - touchViewWH) * 0.5, touchY, touchViewWH, touchViewWH);
    for (int i = 0; i < _touchView.subviews.count; i++) {
        UIButton *btn = [_touchView.subviews objectAtIndex:i];
        int col = i % self.buttonRowCount;
        int row = i / self.buttonRowCount;
        CGFloat btnX = col * (marginX + kButtonW);
        CGFloat btnY = row * (marginY + kButtonH);
        btn.frame = CGRectMake(btnX, btnY, kButtonW, kButtonH);
    }
}

#pragma mark 最大按钮数量
- (void)setButtonsMax:(NSUInteger)buttonsMax{
    if (_buttonsMax != buttonsMax) {
        _buttonsMax = buttonsMax;
        for (UIButton *btn in _touchView.subviews) {
            [btn removeFromSuperview];
        }
        for (int i = 0; i < buttonsMax; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.userInteractionEnabled = NO;
            btn.tag = i;
            [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"gesture_node_selected"] forState:UIControlStateSelected];
            [_touchView addSubview:btn];
        }
    }
}

@end
