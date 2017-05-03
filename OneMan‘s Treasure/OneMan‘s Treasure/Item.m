//
//  Item.m
//  OneMans Treasure
//
//  Created by Christy on 5/2/17.
//  Copyright © 2017 龚梦晨. All rights reserved.
//

#import "Item.h"

@implementation Item

- (instancetype)init {
    return [self initWithUid:@"" andDescription:@"" andRetrieve:@""];
}

- (instancetype)initWithUid:(NSString *)uid andDescription:(NSString *)author andRetrieve:(NSString *)text {
    self = [super init];
    if (self) {
        self.uid = uid;
        self.description = text;
        self.retrieve = text;
    }
    return self;
}

@end
