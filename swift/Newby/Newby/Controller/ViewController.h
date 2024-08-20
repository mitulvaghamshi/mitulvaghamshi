//
//  ViewController.h
//
//  Created by Mitul Vaghamshi on 2022-04-17.
//

#import <UIKit/UIKit.h>
#import "AppProtocol.h"
#import "DBManager.h"

@interface ViewController : UIViewController<AppProtocol>

@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UILabel *searchResult;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *findField;

- (IBAction)searchContact:(UIButton *)sender;
- (IBAction)saveContact:(UIButton *)sender;

@end
