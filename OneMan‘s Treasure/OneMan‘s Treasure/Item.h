//
//  Item.h
//  OneMans Treasure
//
//  Created by Christy on 5/2/17.
//  Copyright © 2017 龚梦晨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject
@property(strong, nonatomic) NSString *uid;
@property(strong, nonatomic) NSString *description;
@property(strong, nonatomic) NSString *retrieve;

- (instancetype)initWithUid:(NSString *)uid
                  andDescription:(NSString *)description
                    andRetrieve:(NSString *)retrieve NS_DESIGNATED_INITIALIZER;
@end
