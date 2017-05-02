//
//  SignUp.h
//  OneMan‘s Treasure
//
//  Created by 龚梦晨 on 3/2/17.
//  Copyright © 2017 龚梦晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface SignUp : UIViewController
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end
