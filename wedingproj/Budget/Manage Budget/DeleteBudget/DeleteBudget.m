//
//  DeleteBudget.m
//  WedingProj
//
//  Created by macmini2 on 2/26/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "DeleteBudget.h"
#import "DeleteBudgetCC.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=budget_delete&"]

@interface DeleteBudget ()

@end

@implementation DeleteBudget

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *delete=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(Delete:)];
    [self.navigationItem setRightBarButtonItem:delete];
    isLoad = YES;
    checkImage = [[NSMutableArray alloc]init];
    scrolvw.delegate = self;
    deletetable.scrollEnabled = NO;
    //InvScroll.frame=CGRectMake(0, 0, 320, 480);
    [self image];
    [scrolvw addSubview:deletetable];
}
-(IBAction)Delete:(UIBarButtonItem *)sender
{
    
    
    NSString *savedata =[[NSString alloc]initWithFormat:@"budget_id=%@&apikey=micronix_10_2014_wedsimple_proj",@"1"];
    NSString* urlTextEscaped = [savedata stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL,urlTextEscaped]] ;
    NSLog(@"%@",url);
    
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSError *error;
    NSURLResponse *response;
    
    NSData *urlData=[NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",data);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //[EventTable setRowHeight: 100.00];
    // Return the number of rows in the section.
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    DeleteBudgetCC *cell = (DeleteBudgetCC *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        UINib* nib = [UINib nibWithNibName:@"DeleteBudgetCC" bundle:nil];
        NSArray* array = [nib instantiateWithOwner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    cell.backgroundColor=[UIColor clearColor];
    cell.checkImgv.tag = indexPath.row;
    //Sets up taprecognizer for each imageview
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    tap.delegate = self;
    [cell.checkImgv addGestureRecognizer:tap];
    //Enable the image to be clicked
    cell.checkImgv.userInteractionEnabled = YES;
    
    if (isLoad == YES) {
        [cell.checkImgv setImage:[UIImage imageNamed:@"index2.jpg"]];
        [checkImage addObject:@"index2.jpg"];
    }
    else{
        [cell.checkImgv setImage:[UIImage imageNamed:[checkImage objectAtIndex:indexPath.row]]];
    }
    
    //cell.EventLbl.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    cell.EventLbl.text=@"budget name";
    
    return cell;
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    // NSLog(@"%d",recognizer.view.tag);
    isLoad = NO;
    if ([[checkImage objectAtIndex:recognizer.view.tag]isEqualToString:@"index2.jpg"] ) {
        [checkImage replaceObjectAtIndex:recognizer.view.tag withObject:@"index.jpg"];
    }
    else{
        [checkImage replaceObjectAtIndex:recognizer.view.tag withObject:@"index2.jpg"];
    }
    [deletetable reloadData];
}
-(void)image
{
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            int tableRowheight = 50*44;
            deletetable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
            scrolvw.contentSize = CGSizeMake(320, tableRowheight);
        }
        else if ([[UIScreen mainScreen] bounds].size.height == 480)
        {
            int tableRowheight = 50*44;
            deletetable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
            scrolvw.contentSize = CGSizeMake(320, tableRowheight);
            
        }
        else
        {
            int tableRowheight = 50*44;
            deletetable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
            scrolvw.contentSize = CGSizeMake(320, tableRowheight);
        }
        
        
    }
    else
    {
        //[bgimgv setImage:[UIImage imageNamed:@"640-1136-inner.png"]];
        int tableRowheight = 50*50;
        deletetable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
        scrolvw.contentSize = CGSizeMake(320, tableRowheight);
        
        
    }
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
