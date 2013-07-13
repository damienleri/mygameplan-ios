#import "AppointmentViewController.h"

@interface AppointmentViewController ()

@end

@implementation AppointmentViewController
@synthesize appointment, nameLabel, dateLabel, noteLabel, tableView;

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

    nameLabel.text = appointment.name;
    noteLabel.text = appointment.note;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEEE MMMM d, YYYY"];
    NSString *dateString = [dateFormat stringFromDate:appointment.date];
    dateLabel.text = dateString;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"editAppointment"]) {
        
        EditAppointmentViewController *nextView = segue.destinationViewController;
        nextView.isEditing = YES;
        nextView.appointment = appointment;
    }
}


@end
