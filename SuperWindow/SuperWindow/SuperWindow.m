//
//  SuperWindow.m
//  SuperWindow
//
//  Created by Jason on 22/05/2017.
//  Copyright © 2017 51talk. All rights reserved.
//

#import "SuperWindow.h"

@implementation SuperWindow {
    UIView *_debugView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInit];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _debugView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _debugView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_debugView];
    _debugView.hidden = YES;
    // 监听截屏事件
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userDidTakeScreenshot:)
                                                 name:UIApplicationUserDidTakeScreenshotNotification object:nil];
}

- (void)setDebugViewController:(UIViewController *)debugViewController {
    
}

- (void)setRootViewController:(UIViewController *)rootViewController {
    [super setRootViewController:rootViewController];
    [self bringSubviewToFront:_debugView];
}

// 监听摇一摇手势
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"开始摇动");
    }
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"取消摇动");
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) { // 判断是否是摇动结束
        _debugView.hidden = !_debugView.hidden;
    }  
    return;  
}
@end
