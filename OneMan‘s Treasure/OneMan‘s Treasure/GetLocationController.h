//
//  GetLocationController.h
//  OneMans Treasure
//
//  Created by Christy on 5/4/17.
//  Copyright © 2017 龚梦晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface GetLocationController : UIViewController <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    int locationFetchCounter;
}

@end
