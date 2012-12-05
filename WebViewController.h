//
//  WebViewController.h
//  idm-iPhone
//
//  Created by Arley Mauricio Duarte on 12/4/12.
//  Copyright (c) 2012 Arley Mauricio Duarte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResponseActionProtocol.h"


@interface WebViewController : UIViewController{
    NSString *redirectURL;

}
@property (weak, nonatomic) IBOutlet UIWebView *webView;



-(void) setRedirectURL:(NSString *)message;

@end
