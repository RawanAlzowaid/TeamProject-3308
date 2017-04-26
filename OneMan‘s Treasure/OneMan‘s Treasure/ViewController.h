//
//  ViewController.h
//  OneMan‘s Treasure
//
//  Created by 龚梦晨 on 3/2/17.
//  Copyright © 2017 龚梦晨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UISearchBarDelegate> {
    IBOutlet UISearchBar *searchBar;
    
    NSArray *allItems;
    NSMutableArray *displayItems;
}


@end

