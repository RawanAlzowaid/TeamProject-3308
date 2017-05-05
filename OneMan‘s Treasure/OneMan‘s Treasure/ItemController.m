//
//  ItemController.m
//  OneMan‘s Treasure
//
//  Created by 龚梦晨 on 4/25/17.
//  Copyright © 2017 龚梦晨. All rights reserved.
//

#import "ItemController.h"
#import <Firebase/Firebase.h>
#import "Item.h"
#import "User.h"
#import "UIViewController+Alerts.h"
#import "CameraViewController.h"
#import "CameraSessionView.h"

@interface ItemController () <CACameraSessionDelegate>
@property (weak, nonatomic) IBOutlet UITextField *itemField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionField;
@property (weak, nonatomic) IBOutlet UITextView *retrieveField;
@property (nonatomic, strong) CameraSessionView *cameraView;
@property (weak, nonatomic) IBOutlet UIImageView *imagePreview;

@end

@implementation ItemController

- (void)viewDidAppear:(BOOL)animated {
    _ref = [[FIRDatabase database] reference];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Back.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 User wants to post item, we take in the details from the text fields on the view, get their location, and load the image and store in database as item.

 @param sender touch signal
 */
- (IBAction)postButtonTouched:(id)sender {
    // [START single_value_read]
    NSString *userID = [FIRAuth auth].currentUser.uid;
    [[[_ref child:@"users"] child:userID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        // Get user value
        User *user = [[User alloc] initWithUsername:snapshot.value[@"username"]];
        
        // [START_EXCLUDE]
        // Add new Item
        [self addItem:userID
                  item:_itemField.text
                     description:_descriptionField.text
                      retrieve:_retrieveField.text];
        // Finish this Activity, back to the stream
        [self.navigationController popViewControllerAnimated:YES];
        // [END_EXCLUDE]
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    // [END single_value_read]
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:@"Item Posted Successfully."
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [_itemField setText:@""];
                             [_descriptionField setText:@""];
                             [_retrieveField setText:@""];
                             _imagePreview.image = nil;
                         }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)addItem:(NSString *)userID item:(NSString *)item description:(NSString *)description retrieve:(NSString *)retrieve {
    // Create new post at /item-post/$userid/$item and at
    // /item/$postid simultaneously
    // [START write_fan_out]
    NSString *key = [[_ref child:@"items"] childByAutoId].key;
    NSDictionary *post = @{@"uid": userID,
                           @"item": item,
                           @"description": description,
                           @"retrieve": retrieve};
    NSDictionary *childUpdates = @{[@"/items/" stringByAppendingString:key]: item,
                                   [NSString stringWithFormat:@"/item-postings/%@/", key]: post};
    [_ref updateChildValues:childUpdates];
    // [END write_fan_out]
}

- (IBAction)backButtonTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 Launches Camera if User Wants to Take a Picture of the Item

 @param sender touch signal
 */
- (IBAction)launchCamera:(id)sender {
    //Set white status bar
    [self setNeedsStatusBarAppearanceUpdate];
    
    //Instantiate the camera view & assign its frame
    _cameraView = [[CameraSessionView alloc] initWithFrame:self.view.frame];
    
    //Set the camera view's delegate and add it as a subview
    _cameraView.delegate = self;
    
    //Apply animation effect to present the camera view
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setDuration:0.6];
    [applicationLoadViewIn setType:kCATransitionReveal];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [[_cameraView layer]addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
    
    [self.view addSubview:_cameraView];
    
    //Customization
    [_cameraView setTopBarColor:[UIColor colorWithRed:0 green:0 blue:0 alpha: 0]];
    //[_cameraView hideFlashButton];
    [_cameraView hideCameraToggleButton];
    //[_cameraView hideDismissButton];
}

-(void)didCaptureImage:(UIImage *)image {
    NSLog(@"CAPTURED IMAGE");
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    [self.cameraView removeFromSuperview];
}

-(void)didCaptureImageWithData:(NSData *)imageData {
    NSLog(@"CAPTURED IMAGE DATA");
    //UIImage *image = [[UIImage alloc] initWithData:imageData];
    //UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    //[self.cameraView removeFromSuperview];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    //Show error alert if image could not be saved
    if (error) [[[UIAlertView alloc] initWithTitle:@"Error!" message:@"Image couldn't be saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)selectButtonTouched:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo {
    [picker dismissViewControllerAnimated:YES completion:nil];
    _imagePreview.image = image;
    [self.view addSubview:_imagePreview];
    NSURL *path = [editingInfo valueForKey:UIImagePickerControllerReferenceURL];
    FIRStorage *storage = [FIRStorage storage];
    FIRStorageReference *storageRef = [storage reference];
    FIRStorageReference *imageRef = [storageRef child:@"item-posts/item2.jpg"];
    FIRStorageUploadTask *uploadTask = [imageRef putFile:path metadata:nil completion:^(FIRStorageMetadata *metadata, NSError *error) {
        if (error != nil) {
            // Uh-oh, an error occurred!
        } else {
            // Metadata contains file metadata such as size, content-type, and download URL.
            NSURL *downloadURL = metadata.downloadURL;
        }
    }];
}

@end
