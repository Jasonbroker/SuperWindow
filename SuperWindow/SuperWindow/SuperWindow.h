//
//  SuperWindow.h
//  SuperWindow
//
//  Created by Jason on 22/05/2017.
//  Copyright © 2017 51talk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SuperWindow;
@protocol SuperWindowCaptureScreenShootDelegate <NSObject>

- (void)superWindow:(SuperWindow *_Nonnull)superWindow didReceiveScreenShoot:(UIImage *_Nonnull)image;



@end

@interface SuperWindow : UIWindow
/* custom debug View Controller to handle debug options */
@property(nullable, nonatomic, strong) UIViewController *debugViewController;
/* can automatically capture home + power key motion and pop a view which can draw something on it
 * default is YES
 */
@property(nonatomic, assign) BOOL captureScreenShootMotion;

@property(nullable, nonatomic, weak)id <SuperWindowCaptureScreenShootDelegate> screenShootDelegate;

@end
