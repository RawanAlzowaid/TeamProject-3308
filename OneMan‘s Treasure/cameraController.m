//
//  cameraController.m
//  OneMan‘s Treasure
//
//  Created by 龚梦晨 on 4/5/17.
//  Copyright © 2017 龚梦晨. All rights reserved.
//

#import "cameraController.h"

@interface cameraController ()

@end

@implementation cameraController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

AVCaptureSession *session;
AVCaptureStillImageOutput *StillImageOutput;

- (void)viewWillAppear:(BOOL)animated {
    session = [[AVCaptureSession alloc] init];
    [session setSessionPreset:AVCaptureSessionPresetPhoto];
    
    AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:&error];
    if ([session canAddInput:deviceInput]) {
        [session addInput:deviceInput];
    }
    
    AVCaptureVideoPreviewLayer *previewlayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [previewlayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    CALayer *rootLayer = [[self view] layer];
    [rootLayer setMasksToBounds:YES];
    CGRect frame = self.frameforCapture.frame;
    
    [previewlayer setFrame:frame];
    
    [rootLayer insertSublayer:previewlayer atIndex:0];
    
    
    StillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [StillImageOutput setOutputSettings:outputSettings];
    
    [session addOutput:StillImageOutput];
    
    [session startRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Take_picutre:(UIButton *)sender {
}

- (IBAction)Select_picture:(UIButton *)sender {
}
@end
