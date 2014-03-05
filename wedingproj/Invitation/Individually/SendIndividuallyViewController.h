//
//  SendIndividuallyViewController.h
//  WedingProj
//
//  Created by Micronixtraining on 2/24/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cell1.h"
@interface SendIndividuallyViewController : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet UITableView *InvTable;
    IBOutlet UIScrollView *InvScroll;
    Cell1 *cell1;
    NSMutableArray *checkImage;
    BOOL isLoad;
    BOOL isCheck;
    
    NSDictionary *json;
    NSMutableArray *jsondata;
    
    NSMutableArray *Gid;
    NSMutableArray *Gname;
    NSMutableArray *GuestStatus;
    NSDictionary *InvJson;
    
}
@property (strong, nonatomic) NSString *eventId;
@property (strong, nonatomic) IBOutlet UIButton *Proced;
- (IBAction)ProcedAction:(UIButton *)sender;

@end
