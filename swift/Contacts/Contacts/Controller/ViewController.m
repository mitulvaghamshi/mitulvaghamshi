//
//  ViewController.m
//
//  Created by Mitul Vaghamshi on 2022-04-17.
//

#import "ViewController.h"
#import "DBManager.h"

@interface ViewController ()

@property AppProtocol *protocol;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (IBAction)saveContact:(UIButton *)sender {
    BOOL isSuccess = NO;
    NSString *alertMsg = @"Unable to save contact.";
    if (_nameField.text.length > 0 && _phoneField.text.length > 0) {
        isSuccess = [[DBManager getSharedInstance] saveContactWithName:_nameField.text andNumber:_phoneField.text];
    } else {
        alertMsg = @"Name or Number cannot be empty!";
    }
    if (isSuccess == YES) {
        [self.view endEditing:YES];
        alertMsg = @"Contact saved Successfully!";
    }
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert" message:alertMsg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)searchContact:(UIButton *)sender {
    if (_findField.text.length > 0) {
        [self.view endEditing:YES];
        NSDictionary *contactsDict = [[DBManager getSharedInstance]findByName:_findField.text];
        if (contactsDict == nil) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Search Result" message:@"No result found." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            NSArray *data = [contactsDict valueForKey:@"SearchResult"];
            NSString *resultString = [[NSString alloc] initWithFormat:@"%@: %@", data[1], data[2]];
            _searchResult.text = resultString;
        }
    }
}

- (void)onComplete {
    [_progressLabel setText:@"Process Complete"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _protocol = [[AppProtocol alloc]init];
    _protocol.delegate = self;
    [_protocol startProcess];
    [_progressLabel setText:@"Processing..."];
}

@end
