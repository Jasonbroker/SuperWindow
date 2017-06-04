//
//  SuperWindow.m
//  SuperWindow
//
//  Created by Jason on 22/05/2017.
//  Copyright © 2017 51talk. All rights reserved.
//

#import "SuperWindow.h"
#import "DebugViewController.h"

@interface SNUIDebuggingInformationOverlay : UIWindow

@end

@implementation SNUIDebuggingInformationOverlay

@end

#define SuppressPerformSelectorLeakWarning(Stuff) \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
        Stuff; \
    _Pragma("clang diagnostic pop")

@implementation SuperWindow {
//    UIView *_debugView;
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
    
    self.debugViewController = [[DebugViewController alloc] initWithNibName:nil bundle:nil];
    self.debugViewController.view.hidden = YES;
    // 默认监听截屏事件
    self.captureScreenShootMotion = YES;
    
    // 激活 UIDebuggingInformationOverlay
    // http://ryanipete.com/blog/ios/swift/objective-c/uidebugginginformationoverlay/
    Class overlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
    SuppressPerformSelectorLeakWarning(
        [overlayClass performSelector:@selector(prepareDebuggingOverlay)];
    )
}

- (void)dealloc {
    // 取消截屏监听
    [self removeScreenShootObserving];
}

- (void)setDebugViewController:(UIViewController *)debugViewController {
    if (_debugViewController != debugViewController) {
        // remove the old debug view from window.
        [_debugViewController.view removeFromSuperview];
        
        _debugViewController = debugViewController;
        _debugViewController.view.frame = self.frame;
        [self addSubview:_debugViewController.view];
    }
}

- (void)setRootViewController:(UIViewController *)rootViewController {
    [super setRootViewController:rootViewController];
    // after`setRootViewController` called, the window will remove all views
    // which have the same size of the window.
    [self addSubview:_debugViewController.view];
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
        self.debugViewController.view.hidden = !self.debugViewController.view.hidden;
    }  
    return;  
}

#pragma mark - notification
// 收到用户截屏
- (void)userDidTakeScreenshot:(NSNotification *)notification {
    if (self.captureScreenShootMotion && [self.screenShootDelegate respondsToSelector:@selector(superWindow:didReceiveScreenShoot:)]) {
        [self.screenShootDelegate superWindow:self didReceiveScreenShoot:[self imageFromView]];
    }
}

- (UIImage *)imageFromView {
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
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
