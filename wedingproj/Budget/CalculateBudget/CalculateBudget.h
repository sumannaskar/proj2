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
    
    IBOutlet UILabel *allocate;
    
    IBOutlet UILabel *allocatetext;
    
    IBOutlet UILabel *balancemain;
    
    IBOutlet UILabel *balancemaintext;
    
    IBOutlet UILabel *Estimate;
    
    
//    NSUserDefaults *prefs;
//    IBOutlet UIButton *done;
    NSDictionary *json;
    
    
    
}
    
@end
