//
//  DeleteVendor.h
//  wedingproj
//
//  Created by macmini2 on 2/28/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeleteVendorCC.h"

@interface DeleteVendor : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    
    
    IBOutlet UIImageView *background;
    IBOutlet UIScrollView *scrolvw;
    IBOutlet UITableView *deletetable;
    NSMutableArray *checkImage;
    DeleteVendorCC *cell;
    BOOL isLoad;
    NSMutableArray *vendorname;
    NSMutableArray *deletearray;
    NSString *passdeleteid;
    
}
@property(nonatomic,retain)NSMutableArray *json;

@end
