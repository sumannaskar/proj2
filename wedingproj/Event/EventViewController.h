//
//  EventViewController.h
//  WedingProj
//
//  Created by Micronix on 21/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cell2.h"


@interface EventViewController : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    
    NSArray *raweventList;

    IBOutlet UITableView *EventTable;
    IBOutlet UIScrollView *EventScroll;
    Cell2 *cell;
    NSMutableArray *checkImage;
    BOOL isLoad;
    
    NSMutableArray *totaleventIdlist;
    
    
     NSString *eventnamestr;
     NSString *startstr;
     NSString *endstr;
     NSString *dresscodestr;
     NSString *venuestr;
     NSString *budgetstr;
    
}

- (IBAction)Add:(UIBarButtonItem *)sender;

- (IBAction)Delete:(UIBarButtonItem *)sender;

@end
