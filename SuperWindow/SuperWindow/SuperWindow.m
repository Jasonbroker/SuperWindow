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
    self.captureScreenShootMotion = YES;
}

- (void)dealloc {
    // 取消截屏监听
    [self removeScreenShootObserving];
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

#pragma mark - notification
// 收到用户截屏
- (void)userDidTakeScreenshot:(NSNotification *)notification {
    if (self.captureScreenShootMotion && [self.screenShootDelegate respondsToSelector:@selector(superWindow:didReceiveScreenShoot:)]) {
        extern CGImageRef UIGetScreenImage();
        UIImage *image = [UIImage imageWithCGImage:UIGetScreenImage()];
        [self.screenShootDelegate superWindow:self
                        didReceiveScreenShoot:image];
    }
}

#pragma mark - helper

- (void)removeScreenShootObserving {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)screenShootObserving {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userDidTakeScreenshot:)
                                                 name:UIApplicationUserDidTakeScreenshotNotification object:nil];
}

#pragma mark setter getter

- (void)setCaptureScreenShootMotion:(BOOL)captureScreenShootMotion {
    if (_captureScreenShootMotion != captureScreenShootMotion) {
        _captureScreenShootMotion = captureScreenShootMotion;
        _captureScreenShootMotion ? [self captureScreenShootMotion] : [self removeScreenShootObserving];
    }
}

@end
