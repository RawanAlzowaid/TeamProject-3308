//
//  LogInViewController.m
//  OneMan‘s Treasure
//
//  Created by 龚梦晨 on 3/2/17.
//  Copyright © 2017 龚梦晨. All rights reserved.
//

#import "LogInViewController.h"
#import "UIViewController+Alerts.h"
#import <Firebase/Firebase.h>

@interface LogInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@end

@implementation LogInViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

/**
 If view appears and user logged in, moves to the main page

 @param animated view appears
 */
- (void)viewDidAppear:(BOOL)animated {
    if ([FIRAuth auth].currentUser) {
        [self performSegueWithIdentifier:@"signIn" sender:nil];
    }
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
 User wants to log in. Checks the email and password in the text box to confirm user, or rejects and give error message.

 @param sender touch signal
 */
- (IBAction)didTapEmailLogin:(id)sender {
    [self showSpinner:^{
        [[FIRAuth auth] signInWithEmail:_emailField.text
                               password:_passwordField.text
                             completion:^(FIRUser *user, NSError *error) {
                                 [self hideSpinner:^{
                                     if (error) {
                                         [self showMessagePrompt:error.localizedDescription];
                                         return;
                                     }
                                     [[[_ref child:@"users"] child:user.uid]
                                      observeEventType:FIRDataEventTypeValue
                                      withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                                          if (![snapshot exists]) {
                                              [self promptForNewUserName:user];
                                          } else {
                                              [self performSegueWithIdentifier:@"signIn"
                                                                        sender:nil];
                                          }
                                      }];
                                 }];
                             }];
    }];
}

- (void)promptForNewUserName:(FIRUser *)user {
    [self showTextInputPromptWithMessage:@"Username:"
                         completionBlock:^(BOOL userPressedOK, NSString *_Nullable username) {
                             if (!userPressedOK || !username.length) {
                                 return;
                             }
                             [self showSpinner:^{
                                 FIRUserProfileChangeRequest *changeRequest =[user profileChangeRequest];
                                 changeRequest.displayName = username;
                                 [changeRequest commitChangesWithCompletion:^(NSError *_Nullable error) {
                                     [self hideSpinner:^{
                                         if (error) {
                                             [self showMessagePrompt:error.localizedDescription];
                                             return;
                                         }
                                         [[[_ref child:@"users"] child:[FIRAuth auth].currentUser.uid]
                                          setValue:@{@"username": username}];
                                         [self performSegueWithIdentifier:@"signIn" sender:nil];
                                     }];
                                 }];
                             }];
                         }];
    
}

#pragma mark - UITextFieldDelegate protocol methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self didTapEmailLogin:nil];
    return YES;
}

@end
