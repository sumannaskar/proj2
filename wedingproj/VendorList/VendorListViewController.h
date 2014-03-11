//
//  VendorListViewController.h
//  wedingproj
//
//  Created by Micronixtraining on 3/11/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VendorCell.h"

@interface VendorListViewController : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
IBOutlet UITableView *InvTable;
IBOutlet UIScrollView *InvScroll;
VendorCell *cell;
NSMutableArray *checkImage;
BOOL isLoad;
BOOL isCheck;
    
    
    NSDictionary *json;
     NSMutableArray *Jsondata;
    
    NSMutableArray *Vid;
     NSMutableArray *Vname;
     NSMutableArray *Vcatagory;
     NSMutableArray *Vcontact;
     NSMutableArray *Vemail;
    
    
}
- (IBAction)DeleteAction:(UIBarButtonItem *)sender;
- (IBAction)AddAction:(UIBarButtonItem *)sender;
@end
