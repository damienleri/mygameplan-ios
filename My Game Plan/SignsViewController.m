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
@synthesize types, signs;

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
}

- (void) viewWillAppear:(BOOL)animated
{
    signs = [[NSMutableArray alloc]init];
    //signs = [[NSMutableArray alloc] initWithArray:types];
//    NSArray *allSigns = [Sign fetchAll];
//    for (Sign *thisSign in allSigns)   NSLog(@"%@, %@", testSign.name, testSign.type);

    for (NSString *type in types) {
        [signs addObject: (NSArray *) [Sign fetchWithPredicate:[NSPredicate predicateWithFormat:@"type=%@", type]]];
    }
    
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
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
    // Return the number of rows in the section.
//    return 0;
//    NSLog(@"%i rows for section %i", [[signs objectAtIndex:section] count], section);

   return [[signs objectAtIndex:section] count];
}

-(NSFetchedResultsController *)fetchedResultsController {
	if (fetchedResultsController == nil) {
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		[fetchRequest setEntity:[Sign entityDescription]];
		
		[fetchRequest setSortDescriptors:[NSArray arrayWithObjects:[[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO], nil]];
		[fetchRequest setFetchBatchSize:30];
		
		self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
																			managedObjectContext:[Sign managedObjectContextForCurrentThread]
																			  sectionNameKeyPath:nil
																					   cacheName:nil];
		
		fetchedResultsController.delegate = self;
		
		
		NSError *error = nil;
		if (![fetchedResultsController performFetch:&error]) {
			NSLog(@"Unresolved error: %@", [error localizedDescription]);
		}
    }
	
	return fetchedResultsController;
}



//-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	   
//}

-(UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Sign";
	
	UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
    
//    Sign *sign = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSArray *sectionArray = [signs objectAtIndex: 0];
    Sign *sign = [sectionArray objectAtIndex: indexPath.row];
	cell.textLabel.text = sign.name;
//	[self configureCell:cell atIndexPath:indexPath];
    
	return cell;
}
-(NSString *)tableView:(UITableView *)_tableView titleForHeaderInSection:(NSInteger)section {
    return [[NSString alloc] initWithFormat:@"%@s", [types objectAtIndex:section] ];
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        Sign *sign = [self.fetchedResultsController objectAtIndexPath:indexPath];
//        [sign delete];
//        [Sign commit];
//    }
//}

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
        nextView.sign = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
    }
    
}

- (IBAction)unwindToSigns:(UIStoryboardSegue *)segue {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
