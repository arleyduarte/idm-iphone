//
//  LoginTableViewController.m
//  idm-iPhone
//
//  Created by Arley Mauricio Duarte on 11/20/12.
//  Copyright (c) 2012 Arley Mauricio Duarte. All rights reserved.
//

#import "LoginTableViewController.h"
#import "ConnectionParameters.h"
#import "WhereIAmViewController.h"

NSURL *gRKCatalogBaseURL = nil;


@interface LoginTableViewController ()

@end

@implementation LoginTableViewController
@synthesize usernameTextField;
@synthesize passwordTextField;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    gRKCatalogBaseURL = [[NSURL alloc] initWithString:BASE_URL];
    _client  = [[RKClient alloc] initWithBaseURL:gRKCatalogBaseURL];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - ResponseActionProtocol methods

-(void)didSucessfullyAction:(NSString *)message{
    NSLog(@"Did sucessfully %@", message);
    [waitingAlert dismissWithClickedButtonIndex:0 animated:YES];
    
    
    [usernameTextField setEnabled:YES];
    [passwordTextField setEnabled:YES];
    
    WhereIAmViewController *whereIAmViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"WhereIAmViewController"];
    [whereIAmViewController setUserId:message];
    
    [[self navigationController] pushViewController:whereIAmViewController animated:YES];

    
}

-(void)didNotSucessfullyAction:(NSString *)message{
    NSLog(@" *********        Did not sucessfully");
    
    [waitingAlert dismissWithClickedButtonIndex:0 animated:YES];
    NSString *reason = @"El nombre de usuario o contraseña es incorrecta. Ingreselos nuevamente";
    NSString *title = @"Datos no validos";
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:reason
                                                   delegate:self
                                          cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
    
    [alert show];
    
    [passwordTextField setText:@""];
    
    
    [usernameTextField setEnabled:YES];
    [passwordTextField setEnabled:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if([usernameTextField.text length] == 0 ){
        [usernameTextField becomeFirstResponder];
        return NO;
    }
    if([passwordTextField.text length] == 0){
        [passwordTextField becomeFirstResponder];
        return NO;
    }


    UserValidatorManager *userValidatorManager = [UserValidatorManager sharedInstance];
    [userValidatorManager setDelegate:self];


    
    NSDictionary *shopParams = [NSDictionary dictionaryWithKeysAndObjects:
                                @"username",usernameTextField.text,
                                @"password",passwordTextField.text,
                                nil];
    
    RKParams *params = [RKParams paramsWithDictionary:shopParams];
    NSLog(@"RKParams HTTPHeaderValueForContentType = %@", [params HTTPHeaderValueForContentType]);
    NSLog(@"RKParams HTTPHeaderValueForContentLength = %d", [params HTTPHeaderValueForContentLength]);
    [_client post:@"/user/validate" params:params delegate:userValidatorManager];
  
    waitingAlert = [[UIAlertView alloc] initWithTitle:@"Por favor espera" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil] ;
    [waitingAlert show];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.center = CGPointMake(waitingAlert.bounds.size.width / 2, waitingAlert.bounds.size.height - 50);
    [indicator startAnimating];
    [waitingAlert addSubview:indicator];
    
    NSLog(@"user name %@", usernameTextField.text);
    
    
    return YES;
}



- (void)viewDidUnload {
    [self setUsernameTextField:nil];
    [self setPasswordTextField:nil];
    [super viewDidUnload];
}
@end

