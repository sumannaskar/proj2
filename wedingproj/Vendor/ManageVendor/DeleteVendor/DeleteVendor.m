//
//  DeleteVendor.m
//  wedingproj
//
//  Created by macmini2 on 2/28/14.
//  Copyright (c) 2014 Suman Naskar. All rights reserved.
//

#import "DeleteVendor.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=vendor_muldel&"]

@interface DeleteVendor ()

@end

@implementation DeleteVendor
@synthesize json;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        json =[[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    vendorname =[[NSMutableArray alloc]init];
    deletearray =[[NSMutableArray alloc]init];
    
    for (NSDictionary *data in json ) {
        [vendorname addObject:[data valueForKey:@"vendor_name"]];
    }
    
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
    NSLog(@"%@",passdeleteid);

    
    NSString *savedata =[[NSString alloc]initWithFormat:@"vendor_id=%@&apikey=micronix_10_2014_wedsimple_proj",passdeleteid];
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
    
    if ([[data valueForKey:@"status" ] isEqual:@"Unable to delete. vendor assigned to Budget or TO-DO list."] ) {
        UIAlertView *nodelete =[[UIAlertView alloc]initWithTitle:@"weading" message:@"Unable to delete\nvendor assigned to Budget or TO-DO list." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [nodelete show];
        
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //[EventTable setRowHeight: 100.00];
    // Return the number of rows in the section.
    return vendorname.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
   cell = (DeleteVendorCC *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        UINib* nib = [UINib nibWithNibName:@"DeleteVendorCC" bundle:nil];
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
    cell.VendorLbl.text=[[json objectAtIndex:indexPath.row] valueForKey:@"vendor_name"];
    
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
    
    
    if ([[checkImage objectAtIndex:recognizer.view.tag]isEqualToString:@"index.jpg"]) {
        
        [deletearray addObject:[NSString stringWithFormat:@"%@",[[json objectAtIndex:recognizer.view.tag] valueForKey:@"vendor_id"]  ]];
        // NSLog(@"%d",recognizer.view.tag);
        NSLog(@"%@",deletearray);
    }
    else
    {
        [deletearray removeObject:[NSString stringWithFormat:@"%@",[[json objectAtIndex:recognizer.view.tag] valueForKey:@"vendor_id"]  ]];
    }
    
    NSString *dash=@"-";
    passdeleteid=@"";
//    int c=0;
//    c=([passdeleteid intValue]+1);
//    NSLog(@"%d",c);
//    passdeleteid =[NSString stringWithFormat:@"%d",c];
//    NSLog(@"%@",passdeleteid);
    for (int i=0;i<deletearray.count;i++)
    {
        if (i==deletearray.count-1) {
            
            
            
            NSString *a=[NSString stringWithFormat:@"%d",[[deletearray objectAtIndex:i] intValue] ];
            passdeleteid =[NSString stringWithFormat:@"%@%@",passdeleteid,a];
            NSLog(@"%@",passdeleteid);
        }
        else
        {
            
        NSString *a=[NSString stringWithFormat:@"%d%@",[[deletearray objectAtIndex:i] intValue],dash ] ;
        passdeleteid =[NSString stringWithFormat:@"%@%@",passdeleteid,a];
        }
        
        
    }
    NSLog(@"%@",deletearray);
    NSLog(@"%@",passdeleteid);
    
    
    
    
    
   // NSLog(@"%d",recognizer.view.tag);
    [deletetable reloadData];
}
-(void)image
{
    if([[UIScreen mainScreen] bounds].size.height  < 600)
    {
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            int tableRowheight = 50*vendorname.count;
            deletetable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
            scrolvw.contentSize = CGSizeMake(320, tableRowheight);
        }
        else if ([[UIScreen mainScreen] bounds].size.height == 480)
        {
            int tableRowheight = 50*vendorname.count;
            deletetable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
            scrolvw.contentSize = CGSizeMake(320, tableRowheight);
            
        }
        else
        {
            int tableRowheight = 50*vendorname.count;
            deletetable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
            scrolvw.contentSize = CGSizeMake(320, tableRowheight);
        }
        
        
    }
    else
    {
        //[bgimgv setImage:[UIImage imageNamed:@"640-1136-inner.png"]];
        int tableRowheight = 50*vendorname.count;
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
