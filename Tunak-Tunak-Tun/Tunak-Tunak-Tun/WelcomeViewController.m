//
//  WelcomeViewController.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "WelcomeViewController.h"
#import "ConsoleViewController.h"

@interface WelcomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *gameOnButton;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)showConsoleViewControllerWithUsername:(NSString*)username {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ConsoleViewController* consoleViewController = [storyboard instantiateViewControllerWithIdentifier:@"ConsoleViewController"];
    consoleViewController.username = username;
    [self presentViewController:consoleViewController animated:YES completion:nil];
}

- (IBAction)onGameOnButtonClick:(id)sender {
    NSString* username = [[NSString alloc] init];
    if ([self.usernameTextField.text isEqualToString:@""]) {
        username = @"Jackass";
    } else {
        username = self.usernameTextField.text;
    }
    [self showConsoleViewControllerWithUsername:[NSString stringWithFormat: @"It's up to you, %@!", username]];
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
