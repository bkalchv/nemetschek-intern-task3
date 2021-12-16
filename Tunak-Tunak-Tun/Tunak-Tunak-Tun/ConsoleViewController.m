//
//  ConsoleViewController.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "ConsoleViewController.h"
#import "OneMoreTimeViewController.h"

@interface ConsoleViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *consoleVCEnterButton;
@property (weak, nonatomic) IBOutlet UILabel *matrixLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@end

@implementation ConsoleViewController

- (void)refreshView {
    self.usernameLabel.text = [NSString stringWithFormat:@"It's up to you, %@!", self.username];
    self.gameEngine = [[Engine alloc] initWithPlayersName:self.username];
    self.consoleVCEnterButton.enabled = YES;
    self.matrixLabel.text = [self.gameEngine.gameBoard stateString];
    [self.gameEngine printBoardState];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self refreshView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gameEngine = [[Engine alloc] initWithPlayersName:self.username];
    self.inputTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.usernameLabel.text = [NSString stringWithFormat:@"It's up to you, %@!", self.username];
    [self.gameEngine printBoardState];
    // Do any additional setup after loading the view.
}

-(void)showInvalidInputAlert {
    UIAlertController* invalidInputAlert = [UIAlertController alertControllerWithTitle: @"Invalid input!" message: [NSString stringWithFormat: @"*Expected input format:*\n a digit <= %tu, followed by space, followed by another digit <= %tu", self.gameEngine.gameBoard.numberOfRows - 1, self.gameEngine.gameBoard.numberOfColumns - 1] preferredStyle:UIAlertControllerStyleAlert];
    [invalidInputAlert addAction: [UIAlertAction actionWithTitle:@"Try again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        self.inputTextField.text = @"";
    } ]];
    [self presentViewController:invalidInputAlert animated:YES completion:nil];
}

- (void)showDrawAlert {
    UIAlertController* drawAlert = [UIAlertController alertControllerWithTitle: @"It's a draw!" message: [NSString stringWithString:self.gameEngine.gameBoard.stateString] preferredStyle:UIAlertControllerStyleAlert];
    [drawAlert addAction: [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        [self showOneMoreTimeViewController];
    } ]];
    [self presentViewController:drawAlert animated:YES completion:nil];
}

- (void)showPlayerWonAlert:(Player*)player {
    UIAlertController* playerWonAlert = [UIAlertController alertControllerWithTitle: [NSString stringWithFormat:@"Player %@ won!", player.name] message: [NSString stringWithString:self.gameEngine.gameBoard.stateString] preferredStyle:UIAlertControllerStyleAlert];
    [playerWonAlert addAction: [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        [self showOneMoreTimeViewController];
    } ]];
    [self presentViewController:playerWonAlert animated:YES completion:nil];
}

- (BOOL)isValidRowIndexInput:(NSString*)input {
    NSUInteger inputUInteger = [input integerValue];
    return inputUInteger >= 0 && inputUInteger < self.gameEngine.gameBoard.numberOfRows;
}

- (BOOL)isValidColumnIndexInput:(NSString*)input {
    NSUInteger inputUInteger = [input integerValue];
    return inputUInteger >= 0 && inputUInteger < self.gameEngine.gameBoard.numberOfColumns;
}

- (BOOL)isStringNumeric:(NSString *)text
{
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:text];
    return [alphaNums isSupersetOfSet:inStringSet];
}

-(BOOL)isValidInput:(NSString*)input {
    NSArray<NSString*>* inputArray = [input componentsSeparatedByString:@" "];
    return inputArray.count == 2 && [self isValidRowIndexInput:inputArray[0]] && [self isValidColumnIndexInput:inputArray[1]] && [self isStringNumeric:inputArray[0]] && [self isStringNumeric:inputArray[1]];
}

- (void)showOneMoreTimeViewController {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OneMoreTimeViewController* oneMoreTimeViewController = [storyboard instantiateViewControllerWithIdentifier:@"OneMoreTimeViewController"];
    self.presentationController.delegate = self;
    [self presentViewController:oneMoreTimeViewController animated:YES completion:nil];
}

- (IBAction)onConsoleVCEnterButton:(id)sender {
    NSString* inputString = self.inputTextField.text;
    
    if ([self isValidInput:inputString]) {
        NSArray<NSString*>* inputArray = [inputString componentsSeparatedByString:@" "];
        NSUInteger inputRowIndex = [inputArray[0] integerValue];
        NSUInteger inputColIndex = [inputArray[1] integerValue];
        
        Cell* selectedCell = [self.gameEngine.gameBoard cellAtRowIndex:inputRowIndex columnIndex:inputColIndex];
        if ([selectedCell isChecked]) {
            NSLog(@"Cell at %tu,%tu already selected! Please select another cell!", inputRowIndex, inputColIndex);
        } else {
            [self.gameEngine selectCellAtRowIndex:inputRowIndex atColumnIndex:inputColIndex byPlayer:self.gameEngine.player1];
            self.matrixLabel.text = [self.gameEngine.gameBoard stateString];
            [self.gameEngine printBoardState];
            
                if (self.gameEngine.freeCellsAmount == 0 || self.gameEngine.isGameOver) {
                    if (self.gameEngine.freeCellsAmount == 0) {
                        NSLog(@"It's a draw. Nobody wins!");
                        [self showDrawAlert];
                        
                    } else if(self.gameEngine.isGameOver) {
                        [self.consoleVCEnterButton setEnabled:NO];
                        [self showPlayerWonAlert: self.gameEngine.player1];
                    }
                    
                } else {
                    [self.gameEngine CPUSelects];
                    self.matrixLabel.text = [self.gameEngine.gameBoard stateString];
                    [self.gameEngine printBoardState];
                    
                    if (self.gameEngine.freeCellsAmount == 0 || self.gameEngine.isGameOver) {
                        if (self.gameEngine.freeCellsAmount == 0) {
                            NSLog(@"It's a draw. Nobody wins!");
                            [self showDrawAlert];
                        } else if(self.gameEngine.isGameOver) {
                            [self.consoleVCEnterButton setEnabled:NO];
                            [self showPlayerWonAlert: self.gameEngine.player2];
                        }
                    }
                }
        }
        
    } else {
        [self showInvalidInputAlert];
        NSLog(@"Invalid input. Try again!");
        NSLog(@"***Expected input: a digit <= %tu, followed by space, followed by another digit <= %tu***", self.gameEngine.gameBoard.numberOfRows - 1, self.gameEngine.gameBoard.numberOfColumns - 1);
    }
    self.inputTextField.text = @"";
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
