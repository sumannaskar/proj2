//
//  ReferViewController.m
//  wedingproj
//
//  Created by Micronix on 04/03/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "ReferViewController.h"
#import "SSKeychain.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL1 [NSURL URLWithString:@"http://bestauctionsoftware.com/micronix_project/cpanel/api.php?request=get_referral&"]
//
#define URL2 [NSURL URLWithString:@"&apikey=micronix_10_2013_micronix_proj"]

@interface ReferViewController ()

@end

@implementation ReferViewController
@synthesize nametxt,emailtxt;
@synthesize scroll,referencebtn,backgoundImgview;
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
    NSLog(@"");
    commntstxtV.text=@"type text here...";
//    UIBarButtonItem *home=[[UIBarButtonItem alloc]initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(Home:)];
//    [self.navigationItem setRightBarButtonItem:home];
    
    [super viewDidLoad];
    [self image];
    
    nametxt.delegate=self;
    emailtxt.delegate=self;
    scroll.contentSize=CGSizeMake(320, 650);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)referencehit:(UIButton *)sender
{
    
    if (self.nametxt.text.length>0 &&commntstxtV.text.length>0&&self.emailtxt.text.length>0&&![commntstxtV.text isEqual:@"type text here..."]){
        
        
        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        if  ([emailTest evaluateWithObject:emailtxt.text] != YES && [emailtxt.text length]!=0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter valid email address" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        }
        else{
            
            //if([InternetValidation connectedToNetwork])
            //{
                //[HUD showUIBlockingIndicatorWithText:@"Loading"];
                NSLog(@"Reference Hit");
                json = [[NSDictionary alloc]init];
                NSError *error;
                
                NSString *refDetails=[NSString stringWithFormat:@"from=%@&name=%@&email=%@&comment=%@",[SSKeychain passwordForService:@"LogIn" account:@"User"],nametxt.text,emailtxt.text,commntstxtV.text];
                NSString* urlTextEscaped = [refDetails stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",URL1,urlTextEscaped,URL2]];
                NSLog(@"my--%@",url);
                NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] initWithURL:url];
                [theRequest setHTTPMethod:@"POST"];
                [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
                NSURLResponse *response;
                
                NSData *urlData=[NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
                
                
                
                json = [NSJSONSerialization
                        JSONObjectWithData:urlData //1
                        
                        options:kNilOptions
                        error:&error];
                //[HUD hideUIBlockingIndicator];
                
                NSLog(@"%@",json);
                
                check = [json valueForKey:@"status"];
                
                if ([check isEqual:@"Referral submitted successfully"]) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Casa De Salud" message:@"Referral Sent" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Casa De Salud" message:@"Contact Already Referred by Another Person" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
                
                
                
                
            //}
//            else
//            {
//                
//                [self connection];
//            }
            
            
        }
    }
    else
    {
        
        
        UIAlertView *fillall =[[UIAlertView alloc]initWithTitle:@"Casa De Salud" message:@"fill all the fields" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [fillall show];
    }
    
    
    
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}
//-(void)connection
//{
//    
//    
//    if ([InternetValidation connectedToNetwork])
//    {
//        
//        NSLog(@"acess fail");
//    }
//    else
//    {
//        UIAlertView *nonet=[[UIAlertView alloc]initWithTitle:@"Casa de Salud App" message:@"No Internet" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
//        [nonet show];
//        
//    }
//}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([commntstxtV.text isEqualToString:@"type text here..."]) {
        commntstxtV.text = @"";
        commntstxtV.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([commntstxtV.text isEqualToString:@""]) {
        commntstxtV.text = @"type text here...";
        commntstxtV.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

#pragma mark -
#pragma mark - dispatching different images for different devices

-(void)image
{
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        [referencebtn setBackgroundImage:[UIImage imageNamed:@"send_y-iphone.png"] forState:UIControlStateNormal];
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            [backgoundImgview setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height == 480)
        {
            [backgoundImgview setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            
        }
        else
        {
            [backgoundImgview setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            
        }
        
        
    }
    else
    {
        if ([[UIScreen mainScreen] bounds].size.height == 1024)
        {
            [backgoundImgview setImage:[UIImage imageNamed:@"normal-background-320.jpg"]];
            [referencebtn setBackgroundImage:[UIImage imageNamed:@"send-ipad.png"] forState:UIControlStateNormal];
        }
        
    }
}


@end
