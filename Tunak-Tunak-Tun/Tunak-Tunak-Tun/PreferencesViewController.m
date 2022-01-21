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
#import "GameConfigurationManager.h"


@interface PreferencesViewController ()
@property (weak, nonatomic) IBOutlet UILabel *gameNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *preferencesMessageLabel;
@property (weak, nonatomic) IBOutlet UISwitch *preferenceUISwitchButton;
@property (weak, nonatomic) IBOutlet UISwitch *preferencesGameModeSwitchButton;
@property (weak, nonatomic) IBOutlet UIButton *gameOnButton;
@end

@implementation PreferencesViewController

- (void)refreshView {
    self.preferencesMessageLabel.text = [NSString stringWithFormat:@"Okay, %@ what will it be today?", [GameConfigurationManager.sharedGameConfigurationManager player1Username]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self refreshView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.preferencesMessageLabel.text = [NSString stringWithFormat:@"Okay, %@ what will it be today?", [GameConfigurationManager.sharedGameConfigurationManager player1Username]];
    [self.gameNameLabel setText:[GameConfigurationManager.sharedGameConfigurationManager currentGameAsString]];
    // Do any additional setup after loading the view.
}

- (void)showConsoleViewController {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ConsoleViewController* consoleViewController = [storyboard instantiateViewControllerWithIdentifier:@"ConsoleViewController"];
    [self presentViewController:consoleViewController animated:YES completion:nil];
}

- (void)showMobileViewController {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MobileUIViewController* mobileUIViewController = [storyboard instantiateViewControllerWithIdentifier:@"MobileUIViewController"];
    [self presentViewController:mobileUIViewController animated:YES completion:nil];
}

- (void)showSecondPlayerNameInputViewController {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SecondPlayerNameInputViewController* secondPlayerNameInputViewController = [storyboard instantiateViewControllerWithIdentifier:@"SecondPlayerNameInputViewController"];
    [self presentViewController:secondPlayerNameInputViewController animated:YES completion:nil];
}


- (IBAction)onGameOnButtonClick:(id)sender {
    
    if (self.preferencesGameModeSwitchButton.isOn) {
        
        if (self.preferenceUISwitchButton.isOn) {
            [GameConfigurationManager.sharedGameConfigurationManager changeToUI: EnumUIMobile];
        } else {
            [GameConfigurationManager.sharedGameConfigurationManager changeToUI: EnumUIConsole];
        }
        
        [GameConfigurationManager.sharedGameConfigurationManager changeToGameMode: GameModeTwoPlayers];
        [self showSecondPlayerNameInputViewController];
    } else {
        
        if (self.preferenceUISwitchButton.isOn) {
            [GameConfigurationManager.sharedGameConfigurationManager changeToUI: EnumUIMobile];
            [self showMobileViewController];
        } else {
            [GameConfigurationManager.sharedGameConfigurationManager changeToUI: EnumUIConsole];
            [self showConsoleViewController];

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
