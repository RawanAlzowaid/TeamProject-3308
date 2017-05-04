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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

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

/**
 User wants to create a profile. We create a database user entry with their username, email, and password, firebase uses bCrypt to store passwords.

 @param sender touch signal
 */
- (IBAction)pressedSignUpButton:(id)sender {
    bool usernameEntered = _usernameField.text && _usernameField.text.length > 0;
    bool passwordEntered = _passwordField.text && _passwordField.text.length > 0;
    bool emailEntered = _emailField.text && _emailField.text.length > 0;
    if (usernameEntered && passwordEntered && emailEntered)
    {
    [self showSpinner:^{
        [[FIRAuth auth] createUserWithEmail:_emailField.text password:_passwordField.text
                                 completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
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
                                                 [self addDomain:_emailField.text];
                                                 [self dismissViewControllerAnimated:YES completion:nil];
                                             }];
                                         }];
                                     }];

                                 }];
    }];
    }
    else {
        [self showMessagePrompt:@"Username, Password, and Email Required"];
    }
    
}

/**
 strips the email address down to just the affiliated school name

 @param candidate : possible email adress with school affiliation
 @return the school name
 */
- (NSString *) validateEmail: (NSString *) candidate {
    if([candidate hasSuffix:@".edu"]){
        NSString *schoolAndDomain = [candidate componentsSeparatedByString:(@"@")][1];
        return [schoolAndDomain componentsSeparatedByString:(@".")][0];
    }
    else {
        return @"NONE";
    }
}

/**
 adds the affiliated school to the database

 @param email : email address with affiliated school
 */
- (void)addDomain:(NSString *)email {
    NSString *domain = [self validateEmail:email];
    NSString *key = [[_ref child:@"domain"] childByAutoId].key;
    NSDictionary *childUpdates = @{[@"/domains/" stringByAppendingString:key]: domain};
    [_ref updateChildValues:childUpdates];
    // [END write_fan_out]
}

@end
