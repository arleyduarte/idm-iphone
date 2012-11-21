//
//  NSString+RFC3875.m
//  idm-iPhone
//
//  Created by Arley Mauricio Duarte on 11/21/12.
//  Copyright (c) 2012 Arley Mauricio Duarte. All rights reserved.
//

#import "NSString+RFC3875.h"

@implementation NSString (RFC3875)
- (NSString *)stringByAddingRFC3875PercentEscapesUsingEncoding:(NSStringEncoding)encoding
{
    CFStringEncoding cfEncoding = CFStringConvertNSStringEncodingToEncoding(encoding);
    NSString *rfcEscaped = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                        NULL,
                                                                                        (__bridge CFStringRef)self,
                                                                                        NULL,
                                                                                        (CFStringRef)@";/?:@&=$+{}<>',.-_",
                                                                                        cfEncoding);
    return rfcEscaped;
}
@end
