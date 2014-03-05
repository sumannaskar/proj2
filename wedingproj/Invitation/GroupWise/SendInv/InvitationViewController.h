//
//  InvitationViewController.h
//  WedingProj
//
//  Created by Micronix on 21/02/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cell.h"
@interface InvitationViewController : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet UITableView *InvTable;
    IBOutlet UIScrollView *InvScroll;
    Cell *cell;
    NSMutableArray *checkImage;
    BOOL isLoad;
    BOOL isCheck;
    
    NSDictionary *json;
    NSMutableArray *jsondata;
    NSMutableArray *Guestid;
    NSMutableArray *Guestname;
     NSMutableArray *GuestStatus;
    
     NSDictionary *InvJson;
}
@property (strong, nonatomic) IBOutlet UIButton *sendBtn;

- (IBAction)SendAction:(UIButton *)sender;

@property (strong, nonatomic) NSString *GroupId;
@property (strong, nonatomic) NSString *EventId;

@end
