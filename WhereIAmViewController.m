//
//  WhereIAmViewController.m
//  idm-iPhone
//
//  Created by Arley Mauricio Duarte on 11/26/12.
//  Copyright (c) 2012 Arley Mauricio Duarte. All rights reserved.
//

#import "WhereIAmViewController.h"
#import "AddCheckinResourceHandler.h"
#import "ConnectionParameters.h"



@interface WhereIAmViewController ()

@end

@implementation WhereIAmViewController
@synthesize myMapView;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
   NSURL *catalogBaseURL = [[NSURL alloc] initWithString:BASE_URL];
    _client  = [[RKClient alloc] initWithBaseURL:catalogBaseURL];
    
	// Do any additional setup after loading the view.
    myMapView.showsUserLocation = YES;
    [myMapView setMapType:MKMapTypeStandard];
    [myMapView setZoomEnabled:YES];
    [myMapView setScrollEnabled:YES];
    self.myMapView.centerCoordinate = self.myMapView.userLocation.location.coordinate;
    
    myMapView.userLocation.title = @"Ubicación actual";
     
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reportCurrentLocation:(id)sender {
    NSLog(@"report current Location");
    
    CLLocation *userLoc = myMapView.userLocation.location;
    
    CLLocationCoordinate2D userCoordinate = [userLoc coordinate];
    
    NSLog(@"User latitude: %f",userCoordinate.latitude);
    

    AddCheckinResourceHandler *resourceHandler = [AddCheckinResourceHandler sharedInstance];
    [resourceHandler setDelegate:self];
    
    NSString *latitude = [NSString stringWithFormat:@"%f", userCoordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", userCoordinate.longitude];
    
    
    NSDictionary *shopParams =[NSDictionary dictionaryWithKeysAndObjects:
                               @"longitude", longitude,
                               @"userId", userId,
                               @"latitude", latitude, nil];
       
    RKParams *params = [RKParams paramsWithDictionary:shopParams];
    [_client post:@"/checkin/add" params:params delegate:resourceHandler];
    
  
    waitingAlert = [[UIAlertView alloc] initWithTitle:@"Por favor espera" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
    [waitingAlert show];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.center = CGPointMake(waitingAlert.bounds.size.width / 2, waitingAlert.bounds.size.height - 50);
    [indicator startAnimating];
    [waitingAlert addSubview:indicator];

    
    
}
-(void) setUserId:(NSString *) message{
    userId = [[NSString alloc] initWithString:message];
    NSLog(@"set user id %@", userId);
}

-(void) didSucessfullyAction:(NSString *) message{
    NSLog(@"Sucessfully action");
    [waitingAlert dismissWithClickedButtonIndex:0 animated:YES];
    
    
}
-(void) didNotSucessfullyAction:(NSString *) message{
    NSLog(@"Unsucessfully");
    [waitingAlert dismissWithClickedButtonIndex:0 animated:YES];
    
}

- (void)viewDidUnload {
    [self setMyMapView:nil];
    [super viewDidUnload];
}
@end
