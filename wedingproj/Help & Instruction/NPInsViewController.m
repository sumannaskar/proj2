//
//  NPInsViewController.m
//  NewProjectThought
//
//  Created by Micronixtraining on 10/10/13.
//  Copyright (c) 2013 Micronix Technologies. All rights reserved.
//

#import "NPInsViewController.h"

@interface NPInsViewController ()

@end

@implementation NPInsViewController
@synthesize Insbgimgv,instxtV;
@synthesize InslightbgImgv,exitButton;

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
    instxtV.text=@"1.Log in to the application with your email and password.\n\n2.After login, you will be moved to Home screen of the Casa de Salud app.\n The Home screen contains the following menus: Scheduling, Notifications, Instructions, Help, About Us\n\n3.Scheduling:Click on SCHEDULING to schedule an appointment. Select your Location and Description and then click on the Proceed button.\nOnce you click on the Proceed button you will be moved to the Calendar from where you can choose a particular date for the appointment.\nThe next screen will show you all the available Slots with an AVAILABLE button on the right side of it.\n Click any of the Slots of your choice and select the CONFIRM BOOKING button.\nYour appointment will be automatically booked on the scheduled day and slot. You will be communicated through a notification.\n\n4.     Notification: Click on the Notifications menu. You can receive any notifications from the admin regarding any activities you do with Casa de Salud app. You can reply back to the admin by clicking on the COMPOSE message icon on the top right corner of the screen. You can also forward the message to any recipient.\n\n5.     Instructions: Click on Instructions to get all necessary information regarding the Casa de Salud app.\n\n6.     Help: Click on HELP to any kind of assistance regarding the Casa de Salud app.\n\n7.     About Us: Click on About Us to know about us.\n\nThe Footer section contains the following menus: MAP, SOCIAL, PRIVACY, REFER A FRIEND\n\n8.     MAP: Click on the MAP to view a selected location on MAP. Select your Location and Description and Click on GET MAP button. You can view the exact location in map.\n\n9.SOCIAL: Click on SOCIAL to check the social profiles of Casa de Salud.\n\n10.  PRIVACY: Click PRIVACY to read our privacy policy.\n\n11.  REFER A FRIEND: Click REFER A FRIEND button to refer this app to any of your friend. Enter the Name, Address, Email, and Mobile number and then click on SEND.\n ";
}
-(IBAction)exitfromApp:(UIBarButtonItem *)sender
{
    
    NSLog(@"exit from app");
    
           //show confirmation message to user
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Confirmation"
                                                            message:@"Do you want to exit?"
                                                           delegate:self
                                                  cancelButtonTitle:@"No"
                                                  otherButtonTitles:@"Yes", nil];
    //        alert.backgroundColor=[UIColor blackColor];
            [alert show];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)  // 0 == the cancel button
    {
        exit(0);
        
        //home button press programmatically
        UIApplication *app = [UIApplication sharedApplication];
        [app performSelector:@selector(suspend)];
        
        //wait 2 seconds while app is going background
        [NSThread sleepForTimeInterval:2.0];
        
        //exit app when app is in background
        //exit(0);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - dispatching different images for different devices

-(void)image
{
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            [Insbgimgv setImage:[UIImage imageNamed:@"640-1136-inner.png"]];
            
            
        }
        else if ([[UIScreen mainScreen] bounds].size.height == 480)
        {
            [Insbgimgv setImage:[UIImage imageNamed:@"320-480-inner.png"]];
            
        }
        else
        {
            [Insbgimgv setImage:[UIImage imageNamed:@"640-1136-inner.png"]];
            
        }
        
        
    }
    else
    {
        if ([[UIScreen mainScreen] bounds].size.height == 1024)
        {
            
           [Insbgimgv setImage:[UIImage imageNamed:@"768-1004-inner.png"]];
        }
        else
        {
            
            [Insbgimgv setImage:[UIImage imageNamed:@"768-1004-inner.png"]];
        }
    }
}



@end
