#import "SignViewController.h"
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
    if ([[segue identifier] isEqualToString:@"newSignEvent"]) {
        SignEvent *event = [SignEvent newEntity];
        event.date = [NSDate date];
//        NSLog(@"creating Sign Event");
        [sign addEventsObject:event];
        [SignEvent commit];
        [Sign commit];
    }
    if ([[segue identifier] isEqualToString:@"signEvents"]) {
        SignEventsViewController *nextView = segue.destinationViewController;
        nextView.sign = sign;
//        NSLog(@"yo");
    }
}


@end
