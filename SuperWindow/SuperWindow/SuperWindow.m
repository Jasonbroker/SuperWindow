//
//  SuperWindow.m
//  SuperWindow
//
//  Created by Jason on 22/05/2017.
//  Copyright © 2017 51talk. All rights reserved.
//

#import "SuperWindow.h"

@implementation SuperWindow


// 监听摇一摇手势
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"开始摇动");
    return;
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"取消摇动");
    return;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) { // 判断是否是摇动结束
        NSLog(@"摇动结束");
    }  
    return;  
}
@end
