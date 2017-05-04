//
//  CameraSessionView.h
//  OneMans Treasure
//
//  Created by Christy on 5/3/17.
//  Copyright © 2017 龚梦晨. All rights reserved.
//

#import <UIKit/UIKit.h>

///Protocol Definition
@protocol CACameraSessionDelegate <NSObject>

@optional - (void)didCaptureImage:(UIImage *)image;
@optional - (void)didCaptureImageWithData:(NSData *)imageData;

@end

@interface CameraSessionView : UIView

//Delegate Property
@property (nonatomic, weak) id <CACameraSessionDelegate> delegate;

//API Functions
- (void)setTopBarColor:(UIColor *)topBarColor;
- (void)hideFlashButton;
- (void)hideCameraToggleButton;
- (void)hideDismissButton;

@end

