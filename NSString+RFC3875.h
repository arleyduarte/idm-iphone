//
//  NSString+RFC3875.h
//  idm-iPhone
//
//  Created by Arley Mauricio Duarte on 11/21/12.
//  Copyright (c) 2012 Arley Mauricio Duarte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RFC3875)
- (NSString *)stringByAddingRFC3875PercentEscapesUsingEncoding:(NSStringEncoding)encoding;
@end
