//
//  WelcomeViewController.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 14.01.22.
//

#import "WelcomeViewController.h"
#import "GamePicturesView.h"
#import "GameConfigurationManager.h"
#import "FirstPlayerNameInputViewController.h"

@interface WelcomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)showPreferencesViewController{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FirstPlayerNameInputViewController* firstPlayerNameInputViewController = [storyboard instantiateViewControllerWithIdentifier:@"FirstPlayerNameInputViewController"];
    firstPlayerNameInputViewController.presentationController.delegate = self ;
    [self presentViewController:firstPlayerNameInputViewController animated:YES completion:nil];
}

- (IBAction)onConfirmButtonClick:(id)sender {
    [self showPreferencesViewController];
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
