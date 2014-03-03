//
//  LoginViewController.m
//  WedingProj
//
//  Created by Micronix on 21/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "RegisterViewController.h"
#define LoginURL1 [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=login&"]
#define LoginURL2 [NSURL URLWithString:@"&apikey=micronix_10_2014_wedsimple_proj"]
#import "SSKeychain.h"
#import "SSKeychainQuery.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    username.delegate=self;
    password.delegate=self;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)AddLoginDetails
{
    NSString *AddLoginData=[[NSString alloc]initWithFormat:@"u_email=%@&password=%@%@",username.text,password.text,LoginURL2];
    NSString* urlTextEscaped = [AddLoginData stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",urlTextEscaped);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LoginURL1,urlTextEscaped]];
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    NSLog(@"%@",url);
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSError *error;
    NSURLResponse *response;
    
    NSData *urlData=[NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    AddLoginDataStr=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",response);
    
    AddLoginmessage= [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
    NSLog(@"%@",AddLoginmessage);
    
    if([[AddLoginmessage valueForKey:@"user_id"] isEqualToString:@""])
    {
        
        UIAlertView *loginfail =[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:[NSString stringWithFormat:@"%@ \n or\n try registration",[AddLoginmessage valueForKey:@"status" ]] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [loginfail show];
    }
    else
    {
        
        UIAlertView *loginsucess =[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:[NSString stringWithFormat:@"%@",[AddLoginmessage valueForKey:@"status" ]] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [loginsucess show];
        
        [SSKeychain setPassword:[AddLoginmessage valueForKey:@"user_id"] forService:@"LoginViewController" account:@"User"];
        HomeViewController *HomeVC =[[HomeViewController alloc]init];
        [self.navigationController pushViewController:HomeVC animated:YES];
    }
}


- (IBAction)loginactn:(UIButton *)sender {
    
    if (username.text.length>0 && password.text.length>0)
    {
       // [HUD showUIBlockingIndicatorWithText:@"Loading.."];
        
        [self AddLoginDetails];
        
    }
    else
    {
        
        UIAlertView *fillall =[[UIAlertView alloc]initWithTitle:@"Wedding Project" message:@"fill all the fields" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [fillall show];
    }
    
}

- (IBAction)signactn:(UIButton *)sender
{
    RegisterViewController *RegisVC =[[RegisterViewController alloc]init];
    [self.navigationController pushViewController:RegisVC animated:YES];
}
@end
