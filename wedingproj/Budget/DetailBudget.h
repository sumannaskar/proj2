//
//  DetailBudget.h
//  WedingProj
//
//  Created by macmini2 on 2/25/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailBudget : UIViewController
{
    IBOutlet UILabel *eventname;
    IBOutlet UILabel *eventnametext;
    
    IBOutlet UILabel *vendername;
    IBOutlet UILabel *vendernametext;
    
    IBOutlet UILabel *Pamentduedate;
    IBOutlet UILabel *Pamentduedatetext;
    
    IBOutlet UILabel *totalamountdue;
    IBOutlet UILabel *totalamountduetext;
    
    IBOutlet UILabel *info;
    IBOutlet UITextView *infotext;
    IBOutlet UIButton *done;
    
    IBOutlet UIButton *edit;
    IBOutlet UILabel *amountpaid;
    IBOutlet UILabel *amountpaidtext;
    
    NSMutableArray *json;
    NSMutableArray *vendorid;
    
    
    
    
}
- (IBAction)done:(id)sender;
- (IBAction)edit:(id)sender;



@end
