//
//  ResourcesViewController.m
//  My Game Plan
//
//  Created by Damien Leri on 7/6/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import "ResourcesViewController.h"
#import "Config.h"
@interface ResourcesViewController ()

@end

@implementation ResourcesViewController
@synthesize sectionLabels,resources;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) resourceInSection:(NSString *)section title:(NSString*)title subtitle:(NSString*)subtitle url:(NSString*)url
{
    [[resources objectForKey:section] addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                    title, @"title",
                                                    subtitle, @"subtitle",
                                                    url, @"url",
                                                    nil]];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    sectionLabels = [[NSMutableArray alloc] initWithObjects:@"Crisis Centers", @"Twitter", @"Facebook", @"Web Sites", nil];
    
    
    resources = [[Config sharedInstance] objectForKey: @"resources"];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[resources allKeys] count];
//    return [sectionLabels count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[resources objectForKey:[sectionLabels objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSMutableDictionary *resource = [[resources objectForKey:[sectionLabels objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    cell.textLabel.text = [resource objectForKey:@"title"];
    cell.detailTextLabel.text = [resource objectForKey:@"subtitle"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}
-(NSString *)tableView:(UITableView *)_tableView titleForHeaderInSection:(NSInteger)section {
    return [sectionLabels objectAtIndex:section];
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
    
    NSMutableDictionary *resource = [[resources objectForKey:[sectionLabels objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];

    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [resource objectForKey:@"url"]]];
    
    

    
    
    
}

@end
