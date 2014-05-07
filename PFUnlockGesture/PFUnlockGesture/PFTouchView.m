//
//  PFTouchView.m
//  PFUnlockGesture
//
//  Created by 若水 on 14-5-6.
//  Copyright (c) 2014年 若水. All rights reserved.
//
#define kDefaultFloat -1.0
#define kDefaultPoint CGPointMake(kDefaultFloat, kDefaultFloat)

#import "PFTouchView.h"

@interface PFTouchView()
{
    NSMutableArray *_selectedButtons; //选中的按钮
    CGPoint _point; //原点
}
@end

@implementation PFTouchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _selectedButtons = [NSMutableArray array];
        _point = kDefaultPoint;
        self.lineColor = [[UIColor orangeColor] colorWithAlphaComponent:0.3];
        self.lineWidth = 12.0;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    _point = [touch locationInView:self];
    UIButton *button = [self isInAnyButton:_point];
    if (button) {
        button.selected = YES;
        [_selectedButtons addObject:button];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    _point = [touch locationInView:self];
    UIButton *btn = [self isInAnyButton:_point];
    if (btn && [_selectedButtons indexOfObject:btn] == NSNotFound) {
        btn.selected = YES;
        [_selectedButtons addObject:btn];
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_selectedButtons.count > 0 && [_delegate respondsToSelector:@selector(touchViewTouchSeq:)]) {
        NSMutableString *str = [[NSMutableString alloc] init];
        for (int i = 0; i < _selectedButtons.count; i++) {
            UIButton *selected = [_selectedButtons objectAtIndex:i];
            [str appendString:[NSString stringWithFormat:@"%d",selected.tag]];
        }
        [_delegate touchViewTouchSeq:str];
    }
    for (UIButton *btn in _selectedButtons) {
        btn.selected = NO;
    }
    _point = kDefaultPoint;
    [_selectedButtons removeAllObjects];
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self touchesEnded:nil withEvent:nil];
}

- (UIButton *)isInAnyButton:(CGPoint)point{
    for (UIButton *btn in self.subviews) {
       BOOL isIn = CGRectContainsPoint(btn.frame, point);
        if (isIn) {
            return btn;
        }
    }
    return nil;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (_selectedButtons.count > 0) {
        UIBezierPath *bezi = [UIBezierPath bezierPath];
        [bezi moveToPoint:[_selectedButtons[0] center]];
        
        for (int i = 1; i < _selectedButtons.count; i++) {
            [bezi addLineToPoint:[[_selectedButtons objectAtIndex:i] center]];
        }
        if (_point.x != kDefaultFloat && _point.y != kDefaultFloat) {
            [bezi addLineToPoint:_point];
        }
        bezi.lineWidth = _lineWidth;
        bezi.lineJoinStyle = kCGLineJoinRound;
        [_lineColor setStroke];
        [bezi stroke];
        [bezi closePath];
    }
}

@end
