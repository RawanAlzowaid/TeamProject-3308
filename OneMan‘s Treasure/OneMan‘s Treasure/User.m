//
//  User.m
//  OneMans Treasure
//
//  Created by Christy on 5/3/17.
//  Copyright © 2017 龚梦晨. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)init {
    return [self initWithUsername:@""];
}

- (instancetype)initWithUsername:(NSString *)username {
    self = [super init];
    if (self) {
        self.username = username;
    }
    return self;
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
