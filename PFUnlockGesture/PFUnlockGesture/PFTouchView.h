//
//  PFTouchView.h
//  PFUnlockGesture
//
//  Created by 若水 on 14-5-6.
//  Copyright (c) 2014年 若水. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PFTouchViewDelegate <NSObject>

@optional
/**触摸序列*/
- (void)touchViewTouchSeq:(NSString *)touchSeq;

@end

@interface PFTouchView : UIView

/**线的颜色*/
@property (nonatomic, strong) UIColor *lineColor;

/**线的宽度*/
@property (nonatomic, assign) CGFloat lineWidth;

/**代理*/
@property (nonatomic, weak) id<PFTouchViewDelegate> delegate;

@end
