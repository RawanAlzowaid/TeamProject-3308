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
                                   [NSString stringWithFormat:@"/item-postings/%@/%@/", userID, key]: post};
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


@end
