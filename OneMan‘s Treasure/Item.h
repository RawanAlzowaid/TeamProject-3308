//
//  Item.h
//  
//
//  Created by Christy on 5/3/17.
//
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
