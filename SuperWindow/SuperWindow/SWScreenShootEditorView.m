//
//  SWScreenShootEditorView.m
//  SuperWindow
//
//  Created by Jason on 01/06/2017.
//  Copyright © 2017 51talk. All rights reserved.
//

#import "SWScreenShootEditorView.h"

@interface SWScreenShootEditorView()

@property (nonatomic, strong)UIImageView *screenShootImageView;

@end

@implementation SWScreenShootEditorView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _screenShootImageView = [[UIImageView alloc] initWithFrame:CGRectInset(frame, 0, -50)];
        _screenShootImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_screenShootImageView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                  screenShoot:(UIImage *)image {
    self = [self initWithFrame:frame];
    if (self) {
        _screenShootImageView.image = image;
    }
    return self;
}

@end
