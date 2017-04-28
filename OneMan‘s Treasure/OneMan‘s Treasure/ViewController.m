//
//  ViewController.m
//  OneMan‘s Treasure
//
//  Created by 龚梦晨 on 3/2/17.
//  Copyright © 2017 龚梦晨. All rights reserved.
//

#import "ViewController.h"
#import "BookController.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)SearchButton:(id)sender {
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Back.png"]];
    
    allItems = [[NSArray alloc] initWithObjects:@"Books", @"Electronics", @"Furniture", @"Accessaries & Jewries", @"Electronic Controller", @"Clothes", @"Tor Game Controller", nil];
    displayItems = [[NSMutableArray alloc] initWithArray:allItems];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object: nil];
}

- (void)keyboardShown:(NSNotification *)note {
    CGRect keyboardFrame;
    [[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText length] == 0) {
        //connect to categories page
        
    }
    else {
        if ([searchText isEqual:@"Books"]){
                BookController *book = [[BookController alloc] initWithNibName:nil bundle:nil];
                [self presentViewController:book animated:YES completion:NULL];
        }
    }
}

//Not showing the keyboard
- (void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar {
    [searchBar resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





/*- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    searchResults = [recipes filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    return YES;
}*/

@end
