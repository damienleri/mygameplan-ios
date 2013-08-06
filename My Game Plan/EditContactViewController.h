
#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import "Contact.h"


@interface EditContactViewController : UITableViewController <ABPeoplePickerNavigationControllerDelegate, UIActionSheetDelegate> 
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (nonatomic) ABRecordID personID;
@property (weak, nonatomic) IBOutlet UITextField *noteInput;
@property (weak, nonatomic) IBOutlet UITextField *nameInput;
@property(strong,nonatomic) Contact *contact;
- (IBAction)showPicker:(id)sender;
- (IBAction)cancelClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UITableViewCell *deleteCell;
@property (nonatomic, assign) id delegate;
- (IBAction)doneClick:(id)sender;
@end
