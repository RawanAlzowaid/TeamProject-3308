//
//  ItemResultsCollectionViewController.h
//  
//
//  Created by Christy on 5/5/17.
//
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface ItemResultsCollectionViewController : UIViewController
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end
