//
//  BudgetListViewController.h
//  wedingproj
//
//  Created by Micronixtraining on 3/6/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BudgetCell.h"

@interface BudgetListViewController : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet UIImageView *BackImgv;
    IBOutlet UIScrollView *BudgetScroll;
    
    IBOutlet UITableView *BudgetTable;
    
    BudgetCell *cell;
    NSMutableArray *checkImage;
    BOOL isLoad;
    
}
- (IBAction)Add:(UIBarButtonItem *)sender;
- (IBAction)Delete:(UIBarButtonItem *)sender;

@end
