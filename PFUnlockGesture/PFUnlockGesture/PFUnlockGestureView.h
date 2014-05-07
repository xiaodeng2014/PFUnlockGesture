//
//  PFUnlockGestureView.h
//  PFUnlockGesture
//
//  Created by 若水 on 14-5-6.
//  Copyright (c) 2014年 若水. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PFUnlockGestureViewDelegate <NSObject>

@optional
/**触摸序列*/
- (void)touchViewTouchSeq:(NSString *)touchSeq;

@end

@interface PFUnlockGestureView : UIView

/**需要展示的View*/
- (void)showInView:(UIView *)view;

/**按钮所在的view的宽高*/
@property (nonatomic, assign) NSUInteger contentViewWH;

/**线的颜色*/
@property (nonatomic, strong) UIColor *lineColor;

/**线的宽度*/
@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, weak) id<PFUnlockGestureViewDelegate> delegate;

@end
