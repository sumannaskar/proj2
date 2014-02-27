//
//  SendIndividuallyViewController.m
//  WedingProj
//
//  Created by Micronixtraining on 2/24/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "SendIndividuallyViewController.h"
#define NIB_NAME @"Cell1"
@interface SendIndividuallyViewController ()

@end

@implementation SendIndividuallyViewController

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
    // Do any additional setup after loading the view from its nib.
    isLoad = YES;
    checkImage = [[NSMutableArray alloc]init];
    InvScroll.delegate = self;
    InvTable.scrollEnabled = NO;
    //InvScroll.frame=CGRectMake(0, 0, 320, 480);
    [self setTableHeight];
    [InvScroll addSubview:InvTable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 50;
}
//for normal table view....


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
// {
//
//     static NSString *cellidentifire;
//     UITableViewCell *cell;
//     cell=[tableView dequeueReusableCellWithIdentifier:cellidentifire];
//     if(cell==nil)
//     {
//         cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifire];
//         cell.textLabel.text=[NSString stringWithFormat:@"%d",a];
//         NSLog(@"%d",a);
//         a=a+1;
//         cell.accessoryType=UITableViewCellStyleDefault;
//         //[cell setSelectionStyle:UITableViewCellSelectionStyleGray];
//         return cell;
//     }
//     return cell;
//
////[NSString stringWithFormat:@"%d",a];
//
// }

//for customize cell......


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    cell1 = (Cell1 *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell1 == nil)
    {
        UINib* nib = [UINib nibWithNibName:NIB_NAME bundle:nil];
        NSArray* array = [nib instantiateWithOwner:self options:nil];
        cell1 = [array objectAtIndex:0];
    }
    cell1.checkImgv.tag = indexPath.row;
    //Sets up taprecognizer for each imageview
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    tap.delegate = self;
    [cell1.checkImgv addGestureRecognizer:tap];
    //Enable the image to be clicked
    cell1.checkImgv.userInteractionEnabled = YES;
    
    if (isLoad == YES) {
        [cell1.checkImgv setImage:[UIImage imageNamed:@"index2.jpg"]];
        [checkImage addObject:@"index2.jpg"];
    }
    else{
        [cell1.checkImgv setImage:[UIImage imageNamed:[checkImage objectAtIndex:indexPath.row]]];
    }
    
    cell1.guestLbl.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    
    [cell1.statusBtn addTarget:self action:@selector(InvStatus:) forControlEvents:UIControlEventTouchUpInside];
    cell1.statusBtn.tag = indexPath.row;
    
    return cell1;
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
    [InvTable reloadData];
}
-(void) InvStatus:(UIButton*)button
{
    NSLog(@"%ld",(long)button.tag);
}

-(void)setTableHeight
{
    
        if([[UIScreen mainScreen] bounds].size.height  < 600)
        {
            [InvTable setRowHeight:60];
            int tableRowheight = 60*50;
            
            InvTable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
            InvScroll.contentSize = CGSizeMake(320, tableRowheight);
            
            
        }
        else
        {
            [InvTable setRowHeight:90];
            int tableRowheight = 90*50;
            InvTable.frame=CGRectMake(0, 0, 320, tableRowheight*2);
            InvScroll.contentSize = CGSizeMake(768, tableRowheight);
            
            
        }

}


@end
