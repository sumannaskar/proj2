//
//  NPHelpViewController.h
//  NewProjectThought
//
//  Created by Micronixtraining on 10/10/13.
//  Copyright (c) 2013 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
// In the import section
//#import "iAd/ADBannerView.h"
//#import "NPAppDelegate.h"

@interface NPHelpViewController : UIViewController<UINavigationControllerDelegate>
    {
       
     
    
    }
@property (retain, nonatomic) IBOutlet UIImageView *helpbgimgv;
@property (retain, nonatomic) IBOutlet UITextView *helptxtV;
@property (retain, nonatomic) IBOutlet UIImageView *InslightbgImgv;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *exitButton;
-(IBAction)exitfromApp:(UIBarButtonItem *)sender;

    
    
    // After the interface
    @property (nonatomic, retain) IBOutlet UIView *contentView;
  //  @property (nonatomic, retain) IBOutlet ADBannerView  *adBannerView;
//@property (nonatomic, retain) NPAppDelegate *appDelegate;

@end
