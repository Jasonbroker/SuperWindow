//
//  SWScreenShootEditorView.h
//  SuperWindow
//
//  Created by Jason on 01/06/2017.
//  Copyright © 2017 51talk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWScreenShootEditorView : UIView

/**
 a designated method which can create a editor view with an original image.

 @param frame view frame
 @param image original image which can be modified then.
 */
- (instancetype)initWithFrame:(CGRect)frame
          screenShoot:(UIImage *)image;

@end
