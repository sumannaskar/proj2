//
//  RSVPViewController.h
//  wedingproj
//
//  Created by Micronix on 05/03/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSVPViewController : UIViewController
{
   NSDictionary *rawrsvplistdic;
    
    IBOutlet UILabel *notsureresltlbl;
    IBOutlet UILabel *invitationsentresult;
    IBOutlet UILabel *acceptedresultlbl;
    IBOutlet UILabel *rejectedresltlbl;
    
    IBOutlet UIImageView *backgroundimgV;
    
    
    IBOutlet UIButton *morebtn;
    
}


@property (strong, nonatomic) NSString *eventID;
- (IBAction)Detailsactn:(UIButton *)sender;

@end
