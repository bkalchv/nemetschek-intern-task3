//
//  PreferencesViewController.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 16.12.21.
//

#import "PreferencesViewController.h"
#import "ConsoleViewController.h"
#import "MobileUIViewController.h"

@interface PreferencesViewController ()
@property (weak, nonatomic) IBOutlet UILabel *preferencesMessageLabel;
@property (weak, nonatomic) IBOutlet UISwitch *preferenceUISwitchButton;
@property (weak, nonatomic) IBOutlet UISwitch *preferencesGameModeSwitchButton;
@property (weak, nonatomic) IBOutlet UIButton *gameOnButton;
@end

@implementation PreferencesViewController

- (void)refreshView {
    self.preferencesMessageLabel.text = [NSString stringWithFormat:@"Okay, %@ what will it be today?", self.username];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self refreshView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.preferencesMessageLabel.text = [NSString stringWithFormat:@"Okay, %@ what will it be today?", self.username];
    // Do any additional setup after loading the view.
}

- (void)showConsoleViewControllerWithUsername:(NSString*)username {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ConsoleViewController* consoleViewController = [storyboard instantiateViewControllerWithIdentifier:@"ConsoleViewController"];
    consoleViewController.username = username;
    [self presentViewController:consoleViewController animated:YES completion:nil];
}

- (void)showMobileViewControllerWithUsername:(NSString*)username {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MobileUIViewController* mobileUIViewController = [storyboard instantiateViewControllerWithIdentifier:@"MobileUIViewController"];
    mobileUIViewController.username = username;
    [self presentViewController:mobileUIViewController animated:YES completion:nil];
}

- (IBAction)onGameOnButtonClick:(id)sender {
    switch (self.preferenceUISwitchButton.isOn) {
        case YES:
            [self showMobileViewControllerWithUsername:self.username];
            break;
        
        case NO:
            [self showConsoleViewControllerWithUsername:self.username];
            break;;
            
        default:
            break;
    }
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
