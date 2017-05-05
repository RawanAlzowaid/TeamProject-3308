//
//  GetLocationController.m
//  OneMans Treasure
//
//  Created by Christy on 5/4/17.
//  Copyright © 2017 龚梦晨. All rights reserved.
//

#import "GetLocationController.h"
#import <CoreLocation/CoreLocation.h>

@interface GetLocationController ()

@end

@implementation GetLocationController


- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    geocoder = [[CLGeocoder alloc] init];
}

/**
 Gets the location of the user from the phone's gps

 @param sender touch signal
 */
- (IBAction)doFetchCurrentLocation:(id)sender {
    locationFetchCounter = 0;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    // we only need to receive the first response, so we skip the others.
    if (locationFetchCounter > 0) return;
    locationFetchCounter++;
    
    //  get location based on coords
    [geocoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks lastObject];
        
        NSString *street = placemark.thoroughfare;
        NSString *city = placemark.locality;
        NSString *posCode = placemark.postalCode;
        NSString *country = placemark.country;
        NSString *state = placemark.administrativeArea;
        
        NSLog(@"we live in %@", state);
        
        // stopping locationManager from fetching again
        [locationManager stopUpdatingLocation];
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"failed to fetch current location : %@", error);
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
- (IBAction)backButtonTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
