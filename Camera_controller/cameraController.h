//
//  cameraController.h
//  OneMan‘s Treasure
//
//  Created by 龚梦晨 on 4/5/17.
//  Copyright © 2017 龚梦晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface cameraController : UIViewController/*{
    IBOutlet UIView *Imageframe;
    IBOutlet UIImageView *Imageview;
}*/

//@interface cameraController : UIViewController <UIImagePickerController, UINavigationControllerOperation>

@property (strong, nonatomic) IBOutlet UIImageView *Camera;

- (IBAction)Take_picutre:(UIButton *)sender;

- (IBAction)Select_picture:(UIButton *)sender;

/*- (IBAction)Take_picutre:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.camerad
}*/
@end
