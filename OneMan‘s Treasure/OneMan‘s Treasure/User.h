//
//  User.h
//  OneMans Treasure
//
//  Created by Christy on 5/3/17.
//  Copyright © 2017 龚梦晨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property(strong, nonatomic) NSString *username;

- (instancetype)initWithUsername:(NSString *)username NS_DESIGNATED_INITIALIZER;

@end
