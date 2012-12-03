//
//  AddCheckinResourceHandler.h
//  idm-iPhone
//
//  Created by Arley Mauricio Duarte on 12/3/12.
//  Copyright (c) 2012 Arley Mauricio Duarte. All rights reserved.
//

#import "ResponseActionProtocol.h"
#import <RestKit/RestKit.h>

@interface AddCheckinResourceHandler :  NSObject <RKRequestDelegate>

@property(nonatomic, retain) id <ResponseActionProtocol> delegate;
+(AddCheckinResourceHandler *)sharedInstance;
@end
