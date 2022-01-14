//
//  FirstPlayerNameInputViewController.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "FirstPlayerNameInputViewController.h"
#import "PreferencesViewController.h"
#import "GameConfigurationManager.h"

@interface FirstPlayerNameInputViewController ()
@property (weak, nonatomic) IBOutlet UIButton *toPreferencesButton;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@end

@implementation FirstPlayerNameInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)showPreferencesViewController{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PreferencesViewController* preferencesViewController = [storyboard instantiateViewControllerWithIdentifier:@"PreferencesViewController"];
    preferencesViewController.presentationController.delegate = self ;
    [self presentViewController:preferencesViewController animated:YES completion:nil];
}

- (IBAction)onToPreferencesButtonClick:(id)sender {
    NSString* username = [[NSString alloc] init];
    if ([self.usernameTextField.text isEqualToString:@""]) {
        username = @"Annonymous Mouse";
    } else {
        username = self.usernameTextField.text;
    }
    [GameConfigurationManager.sharedGameConfigurationManager addPlayer1Username:username];
    [self showPreferencesViewController];
}

-(void)presentationControllerDidDismiss:(UIPresentationController *)presentationController {
    [GameConfigurationManager.sharedGameConfigurationManager resetPlayer1Name];
    [GameConfigurationManager.sharedGameConfigurationManager resetPlayer2Name];
    self.usernameTextField.text = @"";
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
