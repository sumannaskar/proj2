//
//  HomeViewController.h
//  WedingProj
//
//  Created by Micronix on 21/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
{
    
    IBOutlet UIButton *guestbtn;
    
    
    IBOutlet UIButton *invitationbtn;
    
    IBOutlet UIButton *eventbtn;
    
    
    IBOutlet UIButton *todolistbtn;
    
    IBOutlet UIButton *budgetbtn;
    
    IBOutlet UIButton *vendorbtn;
}
@property (strong, nonatomic) UIBarButtonItem *logoutButton;


- (IBAction)guestactn:(UIButton *)sender;
- (IBAction)invitationactn:(UIButton *)sender;
- (IBAction)eventactn:(UIButton *)sender;
- (IBAction)todolistactn:(UIButton *)sender;
- (IBAction)budgetactn:(UIButton *)sender;
- (IBAction)vendoractn:(UIButton *)sender;
@end
