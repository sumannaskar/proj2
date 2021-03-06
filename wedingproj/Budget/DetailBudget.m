//
//  DetailBudget.m
//  WedingProj
//
//  Created by macmini2 on 2/25/14.
//  Copyright (c) 2014 Micronix Technologies. All rights reserved.
//

#import "DetailBudget.h"
#import "EditBudget.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define URL [NSURL URLWithString:@"http://marketingplatform.ca/wedsimple_project/admin/api.php?request=budget_single&"]

@interface DetailBudget ()

@end

@implementation DetailBudget
@synthesize budgetidpass;


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
    infotext.editable=NO;
    json = [[NSMutableArray alloc]init];
    vendorid = [[NSMutableArray alloc]init];
 
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@budget_id=%@&apikey=micronix_10_2014_wedsimple_proj",URL,budgetidpass]];
    NSLog(@"my--%@",url);
    
    // [HUD showUIBlockingIndicatorWithText:@"Loading.."];
    dispatch_async
    (kBgQueue, ^
     {
         NSData* data = [NSData dataWithContentsOfURL:url];
         NSString *tempstring = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
         
         
         if (data.length<1 || [tempstring isEqualToString:@"null"])
         {
             
             
             //[self performSelectorOnMainThread:@selector(serverFail) withObject:nil waitUntilDone:YES];
             
         }
         
         else
         {
             [self performSelectorOnMainThread:@selector(fetchedData:)
                                    withObject:data waitUntilDone:YES];
             
         }
     }
     );
}

-(void)fetchedData:(NSData *)responseData
{
    NSError *error;
    json = [NSJSONSerialization
            JSONObjectWithData:responseData //1
            
            options:kNilOptions
            error:&error];
    
    eventnametext.text=[[[json valueForKey:
                         @"data" ] objectAtIndex:0] valueForKey:@"name"];
    vendernametext.text=[[[json valueForKey:
                          @"data" ] objectAtIndex:0] valueForKey:@"vendor_name"];
    if ([[[[json valueForKey:
           @"data" ] objectAtIndex:0] valueForKey:@"vendor_name"] isEqual:@"select a vendor"]) {
        vendernametext.text=@"";
    }
    else
    {
        vendernametext.text=[[[json valueForKey:
                               @"data" ] objectAtIndex:0] valueForKey:@"vendor_name"];
    }
    Pamentduedatetext.text=[[[json valueForKey:
                              @"data" ] objectAtIndex:0] valueForKey:@"due_date"];
    amountpaidtext.text=[[[json valueForKey:
                           @"data" ] objectAtIndex:0] valueForKey:@"amount_paid"];
    totalamountduetext.text=[[[json valueForKey:
                               @"data" ] objectAtIndex:0] valueForKey:@"amount_due"];
    infotext.text=[[[json valueForKey:
                     @"data" ] objectAtIndex:0] valueForKey:@"info"];
    vendorid =[[[json valueForKey:
                 @"data" ] objectAtIndex:0] valueForKey:@"vendor_id"];
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
}

- (IBAction)edit:(id)sender {
    
//    EditBudget *EditBudget_=[[EditBudget alloc]init];
//    EditBudget_.eventnamepass =[[[json valueForKey:
//                                  @"data" ] objectAtIndex:0] valueForKey:@"name"];
//    EditBudget_.vendernamepass=[[[json valueForKey:
//                                  @"data" ] objectAtIndex:0] valueForKey:@"vendor_name"];
//    EditBudget_.vendoridpass=[[[json valueForKey:
//                                @"data" ] objectAtIndex:0] valueForKey:@"vendor_id"];
//    EditBudget_.paymentduedatepass =[[[json valueForKey:
//                                       @"data" ] objectAtIndex:0] valueForKey:@"due_date"];
//    EditBudget_.amountpaidtodatepass=[[[json valueForKey:
//                                        @"data" ] objectAtIndex:0] valueForKey:@"amount_paid"];
//    EditBudget_.totalamountduepass =[[[json valueForKey:
//                                       @"data" ] objectAtIndex:0] valueForKey:@"amount_due"];
//    EditBudget_.infopass =[[[json valueForKey:
//                             @"data" ] objectAtIndex:0] valueForKey:@"info"];
//    EditBudget_.eventidpass=[[[json valueForKey:
//                               @"data" ] objectAtIndex:0] valueForKey:@"event_id"];
//    EditBudget_.budgetidpass=[[[json valueForKey:
//                                @"data" ] objectAtIndex:0] valueForKey:@"budget_id"];
//    
//    
//    [self.navigationController pushViewController:EditBudget_ animated:YES];
//    
//    
}
@end
