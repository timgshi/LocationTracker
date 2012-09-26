//
//  TSViewController.m
//  LocationTracker
//
//  Created by Tim Shi on 9/15/12.
//  Copyright (c) 2012 Tim Shi. All rights reserved.
//

#import "TSViewController.h"

@interface TSViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation TSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager startMonitoringSignificantLocationChanges];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    for (CLLocation *location in locations) {
        PFObject *obj = [PFObject objectWithClassName:@"TrackedLocations"];
        PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:location.coordinate.latitude
                                                   longitude:location.coordinate.longitude];
        [obj setObject:point forKey:@"location"];
        [obj setObject:[NSNumber numberWithDouble:location.altitude] forKey:@"altitude"];
        [obj setObject:location.timestamp forKey:@"timestamp"];
        [obj saveEventually];
    }
}


@end
