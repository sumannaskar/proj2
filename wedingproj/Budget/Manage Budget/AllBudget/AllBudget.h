//
//  AllBudget.h
//  WedingProj
//
//  Created by macmini2 on 2/26/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllBudgetCC.h"

@interface AllBudget : UIViewController
{
    NSDictionary *jsondata;
    NSMutableArray *json;
    IBOutlet UITableView *allbudget;
    NSMutableArray *budgetname;
    NSMutableArray *budgetid;
    AllBudgetCC *cell;
}
@property(nonatomic,retain)NSString *eventidpass;

- (IBAction)addBudget:(id)sender;
- (IBAction)deleteBudget:(UIBarButtonItem *)sender;

@end
