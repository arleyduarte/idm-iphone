//
//  AddCheckinResourceHandler.m
//  idm-iPhone
//
//  Created by Arley Mauricio Duarte on 12/3/12.
//  Copyright (c) 2012 Arley Mauricio Duarte. All rights reserved.
//

#import "AddCheckinResourceHandler.h"

@implementation AddCheckinResourceHandler
@synthesize delegate;

- (void)requestDidStartLoad:(RKRequest *)request
{
    
}


- (void)request:(RKRequest *)request didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    NSLog(@"user a  didSendBodyData %@", @"");
}

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response
{
    NSLog(@"user a didLoadResponse %@", [response bodyAsString]);
    NSError *err = nil;
    id json = [response parsedBody:&err];
    BOOL success = [[[json objectForKey:@"status"] objectForKey:@"success"] boolValue];
    NSString *description = (NSString *)[[json objectForKey:@"status"] objectForKey:@"description"];
    
    
    
    if(success)
    {
        [delegate didSucessfullyAction:description];
    } else{
        [delegate didNotSucessfullyAction:@""];
    }
}

- (void)request:(RKRequest *)request didFailLoadWithError:(NSError *)error
{
    NSLog(@"user a didFailLoadWithError %@", @"dd");
    [delegate didNotSucessfullyAction:@""];
}

//this is the shared singleton instance
//allocs are forbidden for correct use of the manager
__strong static AddCheckinResourceHandler *sharedManager = nil;
+(AddCheckinResourceHandler *)sharedInstance
{
    
    static dispatch_once_t once_token = 0;
    dispatch_once(&once_token, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

@end
