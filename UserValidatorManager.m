//
//  UserValidatorManager.m
//  idm-iPhone
//
//  Created by Arley Mauricio Duarte on 11/21/12.
//  Copyright (c) 2012 Arley Mauricio Duarte. All rights reserved.
//

#import "UserValidatorManager.h"
#import "NSString+RFC3875.h"
#import "ConnectionParameters.h"
#import "Status.h"

@implementation UserValidatorManager
@synthesize delegate;

NSString* const LoginURL =  @"/user/validate";

-(void)validateUserWithUserName:(NSString *)username password:(NSString *)password
{
    
    NSString *httpBody = [NSString stringWithFormat:@"username=%@&password=%@",
                          [username stringByAddingRFC3875PercentEscapesUsingEncoding:NSUTF8StringEncoding],
                          [password stringByAddingRFC3875PercentEscapesUsingEncoding:NSUTF8StringEncoding]
                          ];
    
    
    NSLog(@"Fetching resource %@", LoginURL);
    
    NSLog(@"httpBody: %@", httpBody);
    
    RKURL *baseURL = [RKURL URLWithBaseURLString:BASE_URL];
    
  RKClient *client = [RKClient clientWithBaseURL:baseURL];
  [RKClient setSharedClient:client];

    RKRequest *request = [[RKClient sharedClient] requestWithResourcePath:LoginURL];
     request.delegate = self;

    [request send];
    
 
}

- (void)requestDidStartLoad:(RKRequest *)request
{
    NSLog(@"requestDidStartLoad");
}

- (void)requestDidTimeout:(RKRequest *)request
{
    NSLog(@"requestDidStartLoad");
}

- (void)requestDidCancelLoad:(RKRequest *)request
{
    NSLog(@"requestDidStartLoad");
}

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response
{
    NSLog(@"requestDidStartLoad");
}

- (void)request:(RKRequest *)request didFailLoadWithError:(NSError *)error
{
    NSLog(@"requestDidStartLoad");
}



@end
