//
//  FeatureViewController.h
//  wedingproj
//
//  Created by Micronixtraining on 2/28/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeatureViewController : UIViewController
{
    
    IBOutlet UIButton *guestbtn;
    
    IBOutlet UIButton *groupbtn;
    
    IBOutlet UIButton *invitationbtn;
    
    IBOutlet UIButton *eventbtn;
    
    
    IBOutlet UIButton *todolistbtn;
    
    IBOutlet UIButton *budgetbtn;
    
    IBOutlet UIButton *vendorbtn;
    
    IBOutlet UIButton *rsvpbtn;
    
    IBOutlet UIImageView *backgroundimgV;
}
- (IBAction)eventactn:(UIButton *)sender;

- (IBAction)todolistactn:(UIButton *)sender;

- (IBAction)budgetactn:(UIButton *)sender;
- (IBAction)vendoractn:(UIButton *)sender;

- (IBAction)guestlistactn:(UIButton *)sender;
- (IBAction)invitationactn:(UIButton *)sender;

- (IBAction)rsvpactn:(UIButton *)sender;
- (IBAction)groupactn:(UIButton *)sender;
@end
