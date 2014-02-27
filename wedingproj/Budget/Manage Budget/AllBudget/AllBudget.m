//
//  AllBudget.m
//  WedingProj
//
//  Created by macmini2 on 2/26/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "AllBudget.h"
#import "DeleteBudget.h"
#import "AddBudget.h"
#import "DetailBudget.h"

@interface AllBudget ()

@end

@implementation AllBudget
@synthesize eventidpass;
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
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
     static NSString *cellidentifire;
     
     UITableViewCell *cell;
     cell=[tableView dequeueReusableCellWithIdentifier:cellidentifire];
     if(cell==nil)
     {
         cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifire];
         cell.textLabel.text=@"budget name";
         
         
         return cell;
         
         
     }
     
     
     return cell;

//[NSString stringWithFormat:@"%d",a];

 }

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *simpleTableIdentifier = @"SimpleTableCell";
//    
//    Customcell *cell= (Customcell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
//    if (cell == nil)
//    {
//        UINib* nib = [UINib nibWithNibName:@"Customcell" bundle:nil];
//        NSArray* array = [nib instantiateWithOwner:self options:nil];
//        cell = [array objectAtIndex:0];
//    }
//    cell.event.text =@"event";
//    cell.budget.text=@"Total budget";
//    return cell;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailBudget *DetailBudget_ =[[DetailBudget alloc]init];
    [self.navigationController pushViewController:DetailBudget_ animated:YES];
    
}

- (IBAction)addBudget:(id)sender
{
    AddBudget *AddBudget_ = [[AddBudget alloc]init];
    [self.navigationController pushViewController:AddBudget_ animated:YES];
    
}
- (IBAction)deleteBudget:(UIBarButtonItem *)sender
{
    DeleteBudget *DeleteBudget_ = [[DeleteBudget alloc]init];
    [self.navigationController pushViewController:DeleteBudget_ animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
