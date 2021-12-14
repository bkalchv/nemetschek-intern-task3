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
@property (weak, nonatomic) IBOutlet UILabel *matrixLabel;
@end

@implementation ConsoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gameEngine = [[Engine alloc] initWithPlayersName:@"Bogdan"];
    self.matrixLabel.hidden = YES;
    [self.gameEngine printBoardState];
    // Do any additional setup after loading the view.
}

-(NSString*)getAllowedInput:(NSUInteger)dimension {
    NSString* indexDecimals = @"0123456789";
    NSString* allowedDecimals = [indexDecimals substringToIndex:(dimension-1)];
    return allowedDecimals;
}

- (BOOL)isValidInput:(NSString*)input {
    NSString* allowedInputDecimals = [self getAllowedInput: self.gameEngine.gameBoard.numberOfRows + 1];
    return input.length == 2 && [[input substringToIndex: 1] rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:allowedInputDecimals]].location != NSNotFound && [[input substringFromIndex:1] rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:allowedInputDecimals]].location != NSNotFound;
}

//- (NSString*)validateInput:(NSString*)input {
//    while (![self isValidInput:input]) {
//        NSLog(@"Invalid input. Try again!");
//        NSLog(@"***Expected input: a digit <= %tu, followed by another digit <= %tu***", self.gameEngine.gameBoard.numberOfRows - 1, self.gameEngine.gameBoard.numberOfColumns - 1);
//        self.consoleVCTextField.text = @"";
//
//      }
//    return input;
//}

- (IBAction)onConsoleVCEnterButton:(id)sender {
    NSString* input = self.consoleVCTextField.text;
    
    if ([self isValidInput:input]) {
        
        NSUInteger inputRowIndex = [input integerValue] / 10;
        NSUInteger inputColIndex = [input integerValue] % 10;
        
        Cell* selectedCell = [self.gameEngine getCellAtRowIndex:inputRowIndex atColumnIndex:inputColIndex];
        if (selectedCell.isChecked) {
            NSLog(@"Cell at %tu,%tu already selected! Please select another cell!", inputRowIndex, inputColIndex);
        } else {
            [self.gameEngine selectCellAtRowIndex:inputRowIndex atColumnIndex:inputColIndex byPlayer:self.gameEngine.players[1]];
            self.matrixLabel.text = [self.gameEngine.gameBoard stateString];
            //[self.matrixLabel sizeToFit];
            //[self.matrixLabel adjustsFontSizeToFitWidth];
            self.matrixLabel.hidden = NO;
            [self.gameEngine printBoardState];
            
                if (self.gameEngine.freeCellsAmount == 0 || self.gameEngine.isGameOver) {
                    if (self.gameEngine.freeCellsAmount == 0) {
                        NSLog(@"It's a draw. Nobody wins!");
                        
                    } else if(self.gameEngine.isGameOver) {
                        [self.consoleVCEnterButton setEnabled:NO];
                    }
                } else {
                    [self.gameEngine CPUSelects];
                    self.matrixLabel.text =[self.gameEngine.gameBoard stateString];
                    //[self.matrixLabel sizeToFit];
                    //[self.matrixLabel adjustsFontSizeToFitWidth];
                    self.matrixLabel.hidden = NO;
                    [self.gameEngine printBoardState];
                }
        }
        
    } else {
        NSLog(@"Invalid input. Try again!");
        NSLog(@"***Expected input: a digit <= %tu, followed by another digit <= %tu***", self.gameEngine.gameBoard.numberOfRows - 1, self.gameEngine.gameBoard.numberOfColumns - 1);
    }
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
