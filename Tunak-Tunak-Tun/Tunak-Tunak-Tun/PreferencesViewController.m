//
//  PreferencesViewController.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 16.12.21.
//

#import "PreferencesViewController.h"
#import "ConsoleViewController.h"
#import "MobileUIViewController.h"
#import "SecondPlayerNameInputViewController.h"

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

- (void)showConsoleViewControllerWithUsername:(NSString*)username ofGameMode:(GameMode)gameMode {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ConsoleViewController* consoleViewController = [storyboard instantiateViewControllerWithIdentifier:@"ConsoleViewController"];
    consoleViewController.username = username;
    consoleViewController.gameMode = gameMode;
    [self presentViewController:consoleViewController animated:YES completion:nil];
}

- (void)showMobileViewControllerWithUsername:(NSString*)username ofGameMode:(GameMode)gameMode {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MobileUIViewController* mobileUIViewController = [storyboard instantiateViewControllerWithIdentifier:@"MobileUIViewController"];
    mobileUIViewController.username = username;
    mobileUIViewController.gameMode = gameMode;
    [self presentViewController:mobileUIViewController animated:YES completion:nil];
}

- (void)showSecondPlayerNameInputViewControllerWithUsername:(NSString*)username UIPreferencesSwitchIsOn:(BOOL)switchState {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SecondPlayerNameInputViewController* secondPlayerNameInputViewController = [storyboard instantiateViewControllerWithIdentifier:@"SecondPlayerNameInputViewController"];
    secondPlayerNameInputViewController.username = username;
    secondPlayerNameInputViewController.isUIPreferenceSwitchOn = switchState;
    [self presentViewController:secondPlayerNameInputViewController animated:YES completion:nil];
}


- (IBAction)onGameOnButtonClick:(id)sender {
    
    if (self.preferencesGameModeSwitchButton.isOn) {
        
        [self showSecondPlayerNameInputViewControllerWithUsername:self.username UIPreferencesSwitchIsOn:self.preferenceUISwitchButton.isOn];
    } else {
        
        if (self.preferenceUISwitchButton.isOn) {
            [self showMobileViewControllerWithUsername:self.username ofGameMode:GameModeOnePlayer];
        } else {
            [self showConsoleViewControllerWithUsername:self.username ofGameMode:GameModeOnePlayer];

        }
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
