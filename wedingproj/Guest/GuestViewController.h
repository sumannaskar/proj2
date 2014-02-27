//
//  GuestViewController.h
//  WedingProj
//
//  Created by Micronix on 21/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuestCell.h"
@interface GuestViewController : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    
    IBOutlet UITableView *InvTable;
    IBOutlet UIScrollView *InvScroll;
    GuestCell *cell1;
    NSMutableArray *checkImage;
    BOOL isLoad;
    
     NSDictionary *json;
    NSDictionary *Deletejson;
    
     NSMutableArray *Gid;
     NSMutableArray *Gname;
     NSMutableArray *role;
     NSMutableArray *email;
     NSMutableArray *GroupId;
     NSMutableArray *NoOfPerson;
}
- (IBAction)DeleteAction:(UIBarButtonItem *)sender;
- (IBAction)AddAction:(UIBarButtonItem *)sender;

@end
