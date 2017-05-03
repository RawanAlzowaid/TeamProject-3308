//
//  ItemController.h
//  OneMan‘s Treasure
//
//  Created by 龚梦晨 on 4/25/17.
//  Copyright © 2017 龚梦晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface ItemController : UIViewController
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end
