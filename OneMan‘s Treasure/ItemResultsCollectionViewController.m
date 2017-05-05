//
//  ItemResultsCollectionViewController.m
//  
//
//  Created by Christy on 5/5/17.
//
//

#import "ItemResultsCollectionViewController.h"
#import <Firebase/Firebase.h>
#import "Item.h"
#import "User.h"

@interface ItemResultsCollectionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *itemSearchTextField;
@property (weak, nonatomic) IBOutlet UITextView *temporaryTextField;
@end

@implementation ItemResultsCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    _ref = [[FIRDatabase database] reference];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/
- (IBAction)searchButtonTouched:(id)sender {
    [[[self.ref child:@"item-postings/"] queryOrderedByChild:@"item"]
     observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
         for(FIRDataSnapshot *child in snapshot.children){
             if([child.value[@"description"] containsString: _itemSearchTextField.text]){
                 _temporaryTextField.text = [NSString stringWithFormat:@"Item:%@ \n Description: %@ \n Where to Get:%@", child.value[@"item"], child.value[@"description"], child.value[@"retrieve"]];
                 NSLog(@"%@",child.value[@"item"]);
             }
         }
     }];
}
- (IBAction)backButtonTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
