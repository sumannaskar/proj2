//
//  TodolistViewController.h
//  WedingProj
//
//  Created by Micronix on 21/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cell3.h"
@interface TodolistViewController : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet UITableView *EventTable;
    IBOutlet UIScrollView *EventScroll;
    Cell3 *cell;
    NSMutableArray *checkImage;
    BOOL isLoad;
}

- (IBAction)Add:(UIBarButtonItem *)sender;
- (IBAction)Delete:(UIBarButtonItem *)sender;

@end
