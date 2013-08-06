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
    [nameLabel sizeToFit];
    [noteLabel sizeToFit];
    //    NSLog(@"auto witdth %@", size.width);
    CGSize size = [sign.note sizeWithFont:noteLabel.font forWidth:200.0 lineBreakMode:NSLineBreakByWordWrapping];
    noteLabel.frame = CGRectMake(noteLabel.frame.origin.x, noteLabel.frame.origin.y, size.width, size.height);
//    noteLabel.frame = CGRectMake(noteLabel.frame.origin.x, noteLabel.frame.origin.y, 200, 40);

//    NSLog(@"updating note %@, %@", sign.note, noteLabel.text);
    
//    [noteLabel sizeToFit];
//    NSLog(@"label width %@", noteLabel.frame.size.width);
    
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

-(BOOL) hasHotline
{
    return [sign.trigger isEqualToString: @"hotline"];
    // Could also check country here
}
-(IBAction)showActionSheet:(id)sender {
    NSString *redButton = nil;

    if (![sign.trigger isEqualToString: @""]) {
        redButton = @"Call Lifeline";
    }
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Next Step" delegate:self cancelButtonTitle:@"Close" destructiveButtonTitle:redButton otherButtonTitles:@"Coping Strategies", @"Contacts", nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleAutomatic;
    [popupQuery showFromTabBar:self.tabBarController.tabBar];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSInteger buttonOffset = [self hasHotline] ? 0 : -1;
    
    if (buttonIndex == buttonOffset) {
        [[Config sharedInstance] callHotline];
        
    } else if (buttonIndex == buttonOffset + 1) {
      [self performSegueWithIdentifier:@"gotoStrategies" sender:self];

    } else if (buttonIndex == buttonOffset + 2) {
      [self performSegueWithIdentifier:@"gotoContacts" sender:self];

    }
    
}


@end
