//
//  SecondPlayerNameInputViewController.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 22.12.21.
//

#import "ConsoleViewController.h"
#import "MobileUIViewController.h"
#import "SecondPlayerNameInputViewController.h"
#import "GameConfigurationManager.h"

@interface SecondPlayerNameInputViewController ()
@property (weak, nonatomic) IBOutlet UILabel *gameNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *secondPlayerNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *gameOnButton;
@end

@implementation SecondPlayerNameInputViewController

- (void)showConsoleViewController {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ConsoleViewController* consoleViewController = [storyboard instantiateViewControllerWithIdentifier:@"ConsoleViewController"];
    consoleViewController.delegateToSecondPlayerVC = self;
    [self presentViewController:consoleViewController animated:YES completion:nil];
}

- (void)showMobileViewController {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MobileUIViewController* mobileUIViewController = [storyboard instantiateViewControllerWithIdentifier:@"MobileUIViewController"];
    mobileUIViewController.delegateToSecondPlayerVC = self;
    [self presentViewController:mobileUIViewController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.gameNameLabel setText:[GameConfigurationManager.sharedGameConfigurationManager currentGameAsString]];
    UITapGestureRecognizer* tapRecoginzer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouchOutsideTextfield)];
    [self.view addGestureRecognizer: tapRecoginzer];
}

- (void) handleTouchOutsideTextfield {
    if ([self.secondPlayerNameTextField.placeholder isEqual:@""]) [self.secondPlayerNameTextField setPlaceholder:@"ex. Johnny Simp"];
    [self.secondPlayerNameTextField resignFirstResponder];
}

- (IBAction)onEditingDidBegin:(id)sender {
    [self.secondPlayerNameTextField setPlaceholder:@""];
}

- (IBAction)onGameOnButtonClick:(id)sender {
    
    NSString* player2Username = [[NSString alloc] init];
    if ([self.secondPlayerNameTextField.text isEqualToString:@""]) {
        player2Username = @"Annonymous Rat";
    } else {
        player2Username = self.secondPlayerNameTextField.text;
    }
    
    [GameConfigurationManager.sharedGameConfigurationManager addPlayer2Username: player2Username];
    
    switch ([GameConfigurationManager.sharedGameConfigurationManager UI]) {
        case EnumUIConsole:
            [self showConsoleViewController];
            break;
        case EnumUIMobile:
            [self showMobileViewController];
            break;
            
        default:
            break;
    }
}

- (void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:^(void){
        [GameConfigurationManager.sharedGameConfigurationManager resetPlayer2Name];
    }];
}

-(void)presentationControllerDidDismiss:(UIPresentationController *)presentationController {
    [GameConfigurationManager.sharedGameConfigurationManager resetPlayer2Name];
    self.secondPlayerNameTextField.text = @"";
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
