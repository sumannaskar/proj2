//
//  DeleteBudget.h
//  WedingProj
//
//  Created by macmini2 on 2/26/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeleteBudget : UIViewController <UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    
    IBOutlet UIImageView *background;
    IBOutlet UIScrollView *scrolvw;
    IBOutlet UITableView *deletetable;
    NSMutableArray *checkImage;
    BOOL isLoad;
    
    
    
    
}

@end
