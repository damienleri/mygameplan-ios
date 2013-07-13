#import "SignViewController.h"
#import "Config.h"
#import "SignEvent.h"
#import "Sign.h"
#import "SignEventsViewController.h"
@interface SignViewController ()

@end

@implementation SignViewController
@synthesize sign, nameLabel, noteLabel;

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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    nameLabel.text = sign.name;
    noteLabel.text = sign.note;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"editSign"]) {
        
        EditSignViewController *nextView = segue.destinationViewController;
        nextView.isEditing = YES;
        nextView.sign = sign;
    }

   
    if ([[segue identifier] isEqualToString:@"signEvents"]) {
        SignEventsViewController *nextView = segue.destinationViewController;
        nextView.sign = sign;
//        NSLog(@"yo");
    }
}

-(void)markSignEvent {
  SignEvent *event = [SignEvent newEntity];
  event.date = [NSDate date];
  [sign addEventsObject:event];
  [SignEvent commit];
  [Sign commit];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {
      [self markSignEvent];
      [self showActionSheet:self];
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

-(IBAction)showActionSheet:(id)sender {
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Next Step" delegate:self cancelButtonTitle:@"Close" destructiveButtonTitle:@"Call Lifeline" otherButtonTitles:@"Coping Strategies", @"Contacts", nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleAutomatic;
    [popupQuery showFromTabBar:self.tabBarController.tabBar];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [[Config sharedInstance] callHotline];
        
    } else if (buttonIndex == 1) {
      [self performSegueWithIdentifier:@"gotoStrategies" sender:self];

    } else if (buttonIndex == 2) {
      [self performSegueWithIdentifier:@"gotoContacts" sender:self];

    }
    
}


@end
