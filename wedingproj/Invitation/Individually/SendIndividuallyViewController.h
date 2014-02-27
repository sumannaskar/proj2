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
}


@end
