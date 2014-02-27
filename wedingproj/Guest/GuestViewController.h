//
//  GuestViewController.h
//  WedingProj
//
//  Created by Micronix on 21/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
//#include "Cell.h"
@interface GuestViewController : UIViewController<UIGestureRecognizerDelegate>
{
    IBOutlet UITableView *GuestTable;
    
    NSMutableArray *checkImage;
     NSDictionary *json;
    
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
