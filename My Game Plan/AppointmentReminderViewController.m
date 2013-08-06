//
//  AppointmentReminderViewController.m
//  My Game Plan
//
//  Created by damien on 7/18/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import "AppointmentReminderViewController.h"
#import "Config.h"
@interface AppointmentReminderViewController ()

@end

@implementation AppointmentReminderViewController
@synthesize intervals, _tableView ,appointment, selectedIndexes, parentVC;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    intervals = [[Config sharedInstance] objectForKey:@"appointment_reminder_intervals"];

    //// Load selected intervals from database
    selectedIndexes = [NSMutableIndexSet indexSet];
    NSInteger index = 0;
    for (NSMutableDictionary *interval in intervals) {
        NSString *field = [interval objectForKey:@"field"];
        SEL s = NSSelectorFromString(field);
        NSString *val = [appointment performSelector: s];
        if (val) {
//            NSLog(@"... adding index upon load: %i, %@, %@", index, val, field);
            [selectedIndexes addIndex:index];
        }
    
        index = index + 1;
    }
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [intervals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    NSDictionary *interval = [intervals objectAtIndex:indexPath.row];

    
//    NSString *field = [interval objectForKey:@"field"];

    if ([selectedIndexes containsIndex:indexPath.row]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    cell.textLabel.text = [interval objectForKey:@"label"];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    if ([selectedIndexes containsIndex:indexPath.row]) {
        [selectedIndexes removeIndex:indexPath.row];
    } else {
        [selectedIndexes addIndex:indexPath.row];
    }
    [tableView reloadData];
    
}

- (IBAction)CancelButton:(id)sender {

  [self dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)SaveButton:(id)sender {
    [self saveReminders];
    [Appointment commit];
    // AppointmentViewController *presentingView = self.parentVC;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) saveReminders
{
  //// Load selected intervals from database
  NSInteger index = 0;
  for (NSMutableDictionary *interval in intervals) {
    NSString *field = [interval objectForKey:@"field"];
    SEL s = NSSelectorFromString(field);
    NSString *val = [appointment performSelector: s];
        

    if ([selectedIndexes containsIndex:index] && ! val) {  //// Let's schedule this and add to DB
           
        [appointment scheduleReminderForInterval:interval];
	 
    } else if (![selectedIndexes containsIndex:index] && val) {  /// Let's unschedule and remove from DB
	  
        [appointment deleteReminderForField: field withValue: val serverOnly: NO];
    }
    index = index + 1;
  }

}
@end
