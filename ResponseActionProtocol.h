//
//  ResponseActionProtocol.h
//  idm-iPhone
//
//  Created by Arley Mauricio Duarte on 11/20/12.
//  Copyright (c) 2012 Arley Mauricio Duarte. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ResponseActionProtocol <NSObject>
@required
-(void) didSucessfullyAction:(NSString *) message;
-(void) didNotSucessfullyAction:(NSString *) message;
@end
