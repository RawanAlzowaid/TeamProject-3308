//
//  SignUp.m
//  OneMan‘s Treasure
//
//  Created by 龚梦晨 on 3/2/17.
//  Copyright © 2017 龚梦晨. All rights reserved.
//

#import "SignUp.h"
#import "UIViewController+Alerts.h"
#import <Firebase/Firebase.h>

@interface SignUp ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *cityField;
@property (weak, nonatomic) IBOutlet UITextField *stateField;
@property (weak, nonatomic) IBOutlet UITextField *zipcodeField;
@end

@implementation SignUp

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
- (IBAction)pressedSignUpButton:(id)sender {
    [self showSpinner:^{
        [[FIRAuth auth] createUserWithEmail:_emailField.text password:_passwordField.text
                                 completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
                                     [self hideSpinner:^{
                                         if (error) {
                                             [self showMessagePrompt:error.localizedDescription];
                                             return;
                                         }
                                     }];
                                     [self showSpinner:^{
                                         FIRUserProfileChangeRequest *changeRequest =
                                         [[FIRAuth auth].currentUser profileChangeRequest];
                                         changeRequest.displayName = _usernameField.text;
                                         [changeRequest commitChangesWithCompletion:^(NSError *_Nullable error) {
                                             [self hideSpinner:^{
                                                 if (error) {
                                                     [self showMessagePrompt:error.localizedDescription];
                                                     return;
                                                 }
                                                 // [START basic_write]
                                                 [[[_ref child:@"users"] child:user.uid]
                                                  setValue:@{@"username": _usernameField.text}];
                                                 // [END basic_write]
                                             }];
                                         }];
                                     }];

                                 }];
    }];
     
    
    [self performSegueWithIdentifier:@"signedUp" sender:nil];
}
                                 
@end
