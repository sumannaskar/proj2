//
//  BudgetViewController.h
//  WedingProj
//
//  Created by Micronix on 21/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BudgetViewController : UIViewController
{
    
    IBOutlet UIButton *CalculateBudget;
    IBOutlet UIButton *ManageBudget;
}
- (IBAction)ManageBudget:(id)sender;
- (IBAction)CalculateBudget:(id)sender;

@end
