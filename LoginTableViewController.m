//
//  LoginTableViewController.m
//  idm-iPhone
//
//  Created by Arley Mauricio Duarte on 11/20/12.
//  Copyright (c) 2012 Arley Mauricio Duarte. All rights reserved.
//

#import "LoginTableViewController.h"
#import "ConnectionParameters.h"

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
    


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - ResponseActionProtocol methods

-(void)didSucessfullyAction:(NSString *)message{
    NSLog(@"Did sucessfully %@", message);
    [usernameTextField setEnabled:YES];
    [passwordTextField setEnabled:YES];
    
}

-(void)didNotSucessfullyAction:(NSString *)message{
    NSLog(@"Did not sucessfully");
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
    
    //disable both user inpuths to avoid text changue during request
   // [usernameTextField setEnabled:NO];
   // [passwordTextField setEnabled:NO];
    
    UIImage *image = [UIImage imageNamed:@"RestKit.png"];
    NSData *imageData  = UIImagePNGRepresentation(image);
    
    
    NSURL *gRKCatalogBaseURL = [[NSURL alloc] initWithString:BASE_URL];
    
    
     _client = [[RKClient alloc] initWithBaseURL:gRKCatalogBaseURL];
    
    RKParams *params = [RKParams params];
    
    [params setData:imageData MIMEType:@"image/png" forParam:@"image2"];
    
    // Log info about the serialization
    NSLog(@"RKParams HTTPHeaderValueForContentType = %@", [params HTTPHeaderValueForContentType]);
    NSLog(@"RKParams HTTPHeaderValueForContentLength = %d", [params HTTPHeaderValueForContentLength]);
    
    

      [_client post:@"/user/validate" params:params delegate:self];
   // UserValidatorManager *userValidatorManager = [[UserValidatorManager alloc]init];
    
   // [userValidatorManager setDelegate:self];
    //[userValidatorManager validateUserWithUserName:usernameTextField.text password:passwordTextField.text];

    
    NSLog(@"user name %@", usernameTextField.text);
    
    
    return YES;
}
- (void)requestDidStartLoad:(RKRequest *)request
{
   
}


- (void)request:(RKRequest *)request didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
NSLog(@"user didSendBodyData %@", usernameTextField.text);
}

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response
{
NSLog(@"user didLoadResponse %@", [response bodyAsString]);
    
}

- (void)request:(RKRequest *)request didFailLoadWithError:(NSError *)error
{
NSLog(@"user didFailLoadWithError %@", usernameTextField.text);
}

- (void)viewDidUnload {
    [self setUsernameTextField:nil];
    [self setPasswordTextField:nil];
    [super viewDidUnload];
}
@end

