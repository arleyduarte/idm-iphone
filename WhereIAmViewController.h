//
//  WhereIAmViewController.h
//  idm-iPhone
//
//  Created by Arley Mauricio Duarte on 11/26/12.
//  Copyright (c) 2012 Arley Mauricio Duarte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ResponseActionProtocol.h"
#import "AddCheckinResourceHandler.h"

@interface WhereIAmViewController : UIViewController <ResponseActionProtocol>{
    RKClient *_client;
    UIAlertView *waitingAlert;
    NSString *userId;

}
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;


- (IBAction)reportCurrentLocation:(id)sender;

-(void) setUserId:(NSString *) message;

@end
