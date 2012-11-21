//
//  UserValidatorManager.h
//  idm-iPhone
//
//  Created by Arley Mauricio Duarte on 11/21/12.
//  Copyright (c) 2012 Arley Mauricio Duarte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseActionProtocol.h"
#import <RestKit/RestKit.h>

@interface UserValidatorManager : NSObject <RKRequestDelegate>

@property(nonatomic, retain) id <ResponseActionProtocol> delegate;
+(UserValidatorManager *)sharedInstance;


-(void) validateUserWithUserName:(NSString *) username password:(NSString *) password;

@end
