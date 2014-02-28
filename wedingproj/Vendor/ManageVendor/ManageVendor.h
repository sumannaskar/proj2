//
//  ManageVendor.h
//  wedingproj
//
//  Created by macmini2 on 2/28/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManageVendorCC.h"

@interface ManageVendor : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIImageView *background;
    IBOutlet UITableView *managevendortable;
    ManageVendorCC *cell;
    
}

@end
