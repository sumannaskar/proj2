//
//  ManageBudget.h
//  WedingProj
//
//  Created by macmini2 on 2/22/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Customcell.h"

@interface ManageBudget : UIViewController
{
    IBOutlet UIImageView *backgroung;
    IBOutlet UITableView *manageTable;
    NSMutableArray *json;
    NSMutableArray *eventname;
    NSMutableArray *eventid;
    Customcell *cell;
}

@end
