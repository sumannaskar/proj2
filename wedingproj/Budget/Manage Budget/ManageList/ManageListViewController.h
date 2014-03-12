//
//  ManageListViewController.h
//  wedingproj
//
//  Created by Micronixtraining on 3/11/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageListViewController : UIViewController
{
    IBOutlet UIImageView *backImgv;
    
    IBOutlet UITableView *tbl;
    
    NSDictionary *json;
    NSMutableArray *jsondata;
    NSMutableArray *CatId;
    NSMutableArray *CatName;
    NSMutableArray *CatBudget;
    NSMutableArray *CatDesc;
}
@property (strong, nonatomic) NSString *eventidstr;
@end
