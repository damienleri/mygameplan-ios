//
//  SignsViewController.m
//  My Game Plan
//
//  Created by Damien Leri on 6/29/13.
//  Copyright (c) 2013 Damien Leri. All rights reserved.
//

#import "SignsViewController.h"
#import "Sign.h"
#import "SignOccurance.h"

@implementation SignsViewController;

@synthesize types, signs, tableView, sectionLabels;

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
    types = [[NSArray alloc] initWithObjects:@"Thought", @"Feeling", @"Action", nil];
//    self.tableView.backgroundView = nil;
}

- (void) viewWillAppear:(BOOL)animated
{

    signs = [[NSMutableArray alloc]init];
    //signs = [[NSMutableArray alloc] initWithArray:types];
//    NSArray *allSigns = [Sign fetchAll];
//    for (Sign *thisSign in allSigns)   NSLog(@"%@, %@", testSign.name, testSign.type);
    sectionLabels = [[NSMutableArray alloc]init];
    
    for (NSString *type in types) {
        NSArray *objects = [Sign fetchWithPredicate:[NSPredicate predicateWithFormat:@"type=%@", type]];
        if ([objects count] > 0) {
           [signs addObject: (NSArray *) objects];
            NSString *label = [[NSString alloc] initWithFormat:@"%@s", type ];
            [sectionLabels addObject: label];
        }
    }
    
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    [tableView reloadData];
    [super viewWillAppear:animated];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [signs count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

   return [[signs objectAtIndex:section] count];
}



-(UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Sign";
	
	UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
    
    Sign *sign = [[signs objectAtIndex: indexPath.section] objectAtIndex: indexPath.row];
	cell.textLabel.text = sign.name;
    
	return cell;
}
-(NSString *)tableView:(UITableView *)_tableView titleForHeaderInSection:(NSInteger)section {
    return [sectionLabels objectAtIndex:section];
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
//    NSString *stringToMove = [[self.reorderingRows objectAtIndex:sourceIndexPath.row] retain];
//    [self.reorderingRows removeObjectAtIndex:sourceIndexPath.row];
//    [self.reorderingRows insertObject:stringToMove atIndex:destinationIndexPath.row];
//    [stringToMove release];
}
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showSign" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showSign"]) {

        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        SignViewController *nextView = segue.destinationViewController;
        Sign *sign = [[signs objectAtIndex: indexPath.section] objectAtIndex: indexPath.row];
        nextView.sign = sign;
        
    }
    
}

- (IBAction)unwindToSigns:(UIStoryboardSegue *)segue {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
