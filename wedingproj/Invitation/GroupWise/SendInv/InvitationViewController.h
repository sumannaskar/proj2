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
}
@end
