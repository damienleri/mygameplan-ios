
#import "EditContactViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface EditContactViewController ()

@end

@implementation EditContactViewController
@synthesize firstNameLabel, lastNameLabel, phoneLabel, personID, contact, noteInput, nameInput, deleteButton, deleteCell, delegate;


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

    if (contact) {
        NSLog(@"have contact %@", contact.name);
        nameInput.text = contact.name;
        noteInput.text = contact.note;
        
        if ([contact.addressBookID intValue] > 0) {
            ABRecordRef person = ABAddressBookGetPersonWithRecordID(ABAddressBookCreate(), (ABRecordID) [contact.addressBookID intValue]);
            if (person) {
                [self displayPerson:person];
                CFRelease(person);
            }
        }
        
    } else {
        NSLog(@"creating new contact");
        firstNameLabel.text = @"";
        lastNameLabel.text = @"";
        phoneLabel.text = @"";
        deleteCell.hidden = YES;
        contact = [Contact newEntity];
        contact.date = [NSDate date];
    }

   UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

   
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


-(void)dismissKeyboard {
    [nameInput resignFirstResponder];
    [noteInput resignFirstResponder];
}

- (IBAction)deleteClick:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:@"Delete"
                                              otherButtonTitles:nil];
    
    CGRect deleteRect = CGRectMake(0, self.view.bounds.size.height-216-44, 320, 44);

    [sheet showFromRect:deleteRect inView:self.view animated:YES];
}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        [contact delete];
        [Contact commit];
        [self performSegueWithIdentifier:@"unwindToContacts" sender:self];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showPicker:(id)sender {
    ABPeoplePickerNavigationController *picker =
    [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)cancelClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneClick:(id)sender {
    if ([nameInput.text isEqualToString:@""]) {
        nameInput.layer.borderWidth = 2.0f;
        nameInput.layer.cornerRadius = 8.0f;
        nameInput.layer.borderColor = [[UIColor redColor] CGColor];
        return;
    }

    [contact setNote: noteInput.text];
    [contact setName: nameInput.text];
    
    [Contact commit];
    
    if (NO) {
    ABRecordRef person = ABAddressBookGetPersonWithRecordID(ABAddressBookCreate(), (ABRecordID) [contact.addressBookID intValue]);

//    [self.delegate displayPerson:person];
    CFRelease(person);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //    [self performSegueWithIdentifier:@"unwindToContacts" sender:self];
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person {

    [contact setAddressBookID: [NSNumber numberWithInt:(int) ABRecordGetRecordID(person)]];
    [self displayPerson:person];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    return NO;
}

- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}


- (void)displayPerson:(ABRecordRef)person
{
    
    NSString* firstName = (__bridge_transfer NSString*)ABRecordCopyValue(person,
                                                                    kABPersonFirstNameProperty);
    NSString* lastName = (__bridge_transfer NSString*)ABRecordCopyValue(person,
                                                   kABPersonLastNameProperty);


    self.firstNameLabel.text = firstName;
    self.lastNameLabel.text = lastName;
    [self.firstNameLabel sizeToFit];
    [self.lastNameLabel sizeToFit];
    CGSize firstNameSize = [firstName sizeWithFont:firstNameLabel.font forWidth:200.0 lineBreakMode:NSLineBreakByWordWrapping];
    firstNameLabel.frame = CGRectMake(firstNameLabel.frame.origin.x, firstNameLabel.frame.origin.y, firstNameSize.width, firstNameSize.height);
    CGSize lastnameSize = [lastName sizeWithFont:lastNameLabel.font forWidth:200.0 lineBreakMode:NSLineBreakByWordWrapping];
    lastNameLabel.frame = CGRectMake(lastNameLabel.frame.origin.x, lastNameLabel.frame.origin.y, lastnameSize.width, lastnameSize.height);


    NSString* phone = nil;
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person,
                                                     kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phoneNumbers) > 0) {
        phone = (__bridge_transfer NSString*)
        ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
    } else {
        phone = @"";
    }
    self.phoneLabel.text = phone;
    [self.phoneLabel sizeToFit];

    CFRelease(phoneNumbers);
    [self.tableView reloadData];

}
@end
