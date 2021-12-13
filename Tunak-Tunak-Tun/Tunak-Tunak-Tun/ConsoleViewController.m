//
//  ConsoleViewController.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "ConsoleViewController.h"

@interface ConsoleViewController ()
@property (weak, nonatomic) IBOutlet UITextField *consoleVCTextField;
@property (weak, nonatomic) IBOutlet UIButton *consoleVCEnterButton;
@end

@implementation ConsoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gameEngine = [[Engine alloc] initWithPlayersName:@"Bogdan"];
    [self.gameEngine printBoardState];
    // Do any additional setup after loading the view.
}

- (IBAction)onConsoleVCEnterButton:(id)sender {
    NSString* input = self.consoleVCTextField.text;
    // if input == @""?
    
    NSUInteger inputRowIndex = [input integerValue] / 10;
    NSUInteger inputColIndex = [input integerValue] % 10;
    [self.gameEngine selectCellAtRowIndex:inputRowIndex atColumnIndex:inputColIndex byPlayer:self.gameEngine.players[1]];
    [self.gameEngine printBoardState];
    [self.gameEngine CPUSelects];
    [self.gameEngine printBoardState];
    self.consoleVCTextField.text = @"";
}
- (IBAction)onConsoleVCPrintStateButtonClick:(id)sender {
    [self.gameEngine printBoardState];
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
