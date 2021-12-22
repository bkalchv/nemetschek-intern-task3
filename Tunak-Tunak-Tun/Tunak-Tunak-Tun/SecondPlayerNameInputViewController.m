//
//  SecondPlayerNameInputViewController.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 22.12.21.
//

#import "ConsoleViewController.h"
#import "MobileUIViewController.h"
#import "SecondPlayerNameInputViewController.h"

@interface SecondPlayerNameInputViewController ()
@property (weak, nonatomic) IBOutlet UITextField *SecondPlayerNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *GameOnButton;
@end

@implementation SecondPlayerNameInputViewController

- (void)showConsoleViewControllerWithPlayer1Username:(NSString*)player1Username player2Username:(NSString*)player2Username {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ConsoleViewController* consoleViewController = [storyboard instantiateViewControllerWithIdentifier:@"ConsoleViewController"];
    consoleViewController.username = player1Username;
    consoleViewController.player2Username = player2Username;
    consoleViewController.gameMode = GameModeTwoPlayers;
    [self presentViewController:consoleViewController animated:YES completion:nil];
}

- (void)showMobileViewControllerWithPlayer1Username:(NSString*)player1Username player2Username:(NSString*)player2Username {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MobileUIViewController* mobileUIViewController = [storyboard instantiateViewControllerWithIdentifier:@"MobileUIViewController"];
    mobileUIViewController.username = player1Username;
    mobileUIViewController.player2Username = player2Username;
    mobileUIViewController.gameMode = GameModeTwoPlayers;
    [self presentViewController:mobileUIViewController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)onGameOnButtonClick:(id)sender {
    if (self.isUIPreferenceSwitchOn) {
        [self showMobileViewControllerWithPlayer1Username:self.username player2Username: self.SecondPlayerNameTextField.text];
    } else {
        [self showConsoleViewControllerWithPlayer1Username:self.username player2Username: self.SecondPlayerNameTextField.text];
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
