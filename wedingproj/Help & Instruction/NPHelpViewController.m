//
//  NPHelpViewController.m
//  NewProjectThought
//
//  Created by Micronixtraining on 10/10/13.
//  Copyright (c) 2013 Micronix Technologies. All rights reserved.
//

#import "NPHelpViewController.h"



@interface NPHelpViewController ()

@end

@implementation NPHelpViewController
@synthesize helpbgimgv,helptxtV;
@synthesize InslightbgImgv,exitButton;

@synthesize contentView = _contentView;
//@synthesize adBannerView = _adBannerView;
//@synthesize appDelegate=_appDelegate;

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
    [self image];
    exitButton=[[UIBarButtonItem alloc]initWithTitle:@"Exit" style:UIBarButtonItemStylePlain target:self action:@selector(exitfromApp:)];
    [self.navigationItem setRightBarButtonItem:exitButton];
    
     [InslightbgImgv setImage:[UIImage imageNamed:@"tp-bg.png"]];
    helptxtV.text=@"1. Getting the \"No internet \" message check your internet connection. \n\n2. Getting \"server not responding\" message please try few moments later. \n\n3. Getting long \"Loading..\" message check your internet connection speed.\n\n4.Always you have to book a slot one day before your current date. \n\nIf you face any other issue please feel free to contact us. we would love to hear from you. ";

    // banner view works start
    
//    self.adBannerView=[[ADBannerView alloc]initWithAdType:ADAdTypeBanner];
//    self.adBannerView.delegate=self;
//    
// 
//    // setting my banner's origin to bottom most part of my screen so that it is not visible at first
//    
//    CGRect bannerinitialFrame;
//    bannerinitialFrame.origin.x=self.view.frame.size.width;
//    bannerinitialFrame.origin.y=self.view.frame.size.height;
//    self.adBannerView.frame=bannerinitialFrame;
//    [self.view addSubview:self.adBannerView];
  
 
    
}

#pragma mark -
#pragma mark - exiting from showing from alert view

-(IBAction)exitfromApp:(UIBarButtonItem *)sender
{
    //show confirmation message to user
    UIAlertView* alert1 = [[UIAlertView alloc] initWithTitle:@"Confirmation"
                                                     message:@"Do you want to exit?"
                                                    delegate:self
                                           cancelButtonTitle:@"No"
                                           otherButtonTitles:@"Yes", nil];
    [alert1 show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)  // 0 == the cancel button
    {
        
        
        //home button press programmatically
        UIApplication *app = [UIApplication sharedApplication];
        [app performSelector:@selector(suspend)];
        
        //wait 2 seconds while app is going background
        [NSThread sleepForTimeInterval:2.0];
        exit(0);
        
    }
}

#pragma mark -
#pragma mark - dispatching different images for different devices

-(void)image
{
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
             [helpbgimgv setImage:[UIImage imageNamed:@"640-1136-inner.png"]];
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height == 480)
        {
             [helpbgimgv setImage:[UIImage imageNamed:@"320-480-inner.png"]];
            
        }
        else
        {
            [helpbgimgv setImage:[UIImage imageNamed:@"640-1136-inner.png"]];
            
        }
        
        
    }
    else
    {
        if ([[UIScreen mainScreen] bounds].size.height == 1024)
        {
            
            [helpbgimgv setImage:[UIImage imageNamed:@"768-1004-inner.png"]];
        }
        else
        {
            
             [helpbgimgv setImage:[UIImage imageNamed:@"768-1004-inner.png"]];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
