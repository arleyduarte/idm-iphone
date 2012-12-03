//
//  LoginTableViewController.h
//  idm-iPhone
//
//  Created by Arley Mauricio Duarte on 11/20/12.
//  Copyright (c) 2012 Arley Mauricio Duarte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResponseActionProtocol.h"
#import "UserValidatorManager.h"

@interface LoginTableViewController : UITableViewController <ResponseActionProtocol>{
    RKClient *_client;
    UIAlertView *waitingAlert;
}
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end
