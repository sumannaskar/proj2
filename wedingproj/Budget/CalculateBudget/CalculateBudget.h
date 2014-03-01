//
//  CalculateBudget.h
//  WedingProj
//
//  Created by macmini2 on 2/22/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
long budget;
@interface CalculateBudget : UIViewController

{
    
    IBOutlet UILabel *yourbudgetlevel;
    IBOutlet UITextField *yourbudgettext;
    IBOutlet UILabel *allocate;
    IBOutlet UILabel *allocatetext;
    IBOutlet UILabel *balancemain;
    IBOutlet UILabel *balancemaintext;
    NSUserDefaults *prefs;
    IBOutlet UIButton *done;
    NSMutableArray *json;
    
    
    
}

- (IBAction)done:(id)sender;
    


@end
