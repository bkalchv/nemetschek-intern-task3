//
//  ConsoleViewController.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "ConsoleViewController.h"
#import "OneMoreTimeViewController.h"
#import "Engine.h"

@interface ConsoleViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *consoleVCEnterButton;
@property (weak, nonatomic) IBOutlet UILabel *matrixLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@end

@implementation ConsoleViewController

- (void)refreshView {
    switch ([GameConfigurationManager.sharedGameConfigurationManager gameMode]) {
        case GameModeOnePlayer:
            self.gameEngine = [[Engine alloc] initWithPlayersName: [GameConfigurationManager.sharedGameConfigurationManager player1Username]];
            break;
            
        case GameModeTwoPlayers:
            self.gameEngine = [[Engine alloc] initWithPlayer1Name:[GameConfigurationManager.sharedGameConfigurationManager player1Username] player2Name: [GameConfigurationManager.sharedGameConfigurationManager player2Username]];
            break;
            
        default:
            break;
    }
    
    self.usernameLabel.text = [NSString stringWithFormat:@"It's up to you, %@!", [self.gameEngine currentPlayer].name];
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
    
    switch ([GameConfigurationManager.sharedGameConfigurationManager gameMode]) {
        case GameModeOnePlayer:
            self.gameEngine = [[Engine alloc] initWithPlayersName: [GameConfigurationManager.sharedGameConfigurationManager player1Username]];
            break;
        case GameModeTwoPlayers:
            self.gameEngine = [[Engine alloc] initWithPlayer1Name:[GameConfigurationManager.sharedGameConfigurationManager player1Username] player2Name: [GameConfigurationManager.sharedGameConfigurationManager player2Username]];
            break;
            
        default:
            break;
    }
    
    self.inputTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.usernameLabel.text = [NSString stringWithFormat:@"It's up to you, %@!", [self.gameEngine currentPlayer].name];
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

//- (void)showAlreadySelectedAlertForCell:(Cell*)cell {
//    UIAlertController* alreadySelectedAlert = [UIAlertController alertControllerWithTitle: [NSString stringWithFormat:@"Cell [%tu,%tu] has already been selected!", [cell rowIndex], [cell colIndex]] message: @"Please, select another cell." preferredStyle:UIAlertControllerStyleAlert];
//    [alreadySelectedAlert addAction: [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler: nil]];
//    [self presentViewController:alreadySelectedAlert animated:YES completion:nil];
//}

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

- (void)handleWin {
    NSLog(@"%@ won!", self.gameEngine.currentPlayer.name);
    NSLog(@"Game over!");
    [self.consoleVCEnterButton setEnabled:NO];
    [self showPlayerWonAlert: self.gameEngine.currentPlayer];
}

- (void)handleDraw {
    NSLog(@"It's a draw. Nobody wins!");
    [self.consoleVCEnterButton setEnabled:NO];
    [self showDrawAlert];
}

-(void)printCurrentPlayerSelection {
    NSLog(@"Player: %tu selected: %tu %tu", self.gameEngine.currentPlayer.playerID, [self.gameEngine.currentPlayer.lastSelectedCell indexAtPosition:0], [self.gameEngine.currentPlayer.lastSelectedCell indexAtPosition:1]);
}

- (IBAction)onConsoleVCEnterButton:(id)sender {
    NSString* inputString = self.inputTextField.text;
    
    if ([self isValidInput:inputString]) {
        NSArray<NSString*>* inputArray = [inputString componentsSeparatedByString:@" "];
        NSUInteger inputRowIndex = [inputArray[0] integerValue];
        NSUInteger inputColIndex = [inputArray[1] integerValue];
        
        NSIndexPath* inputIndexPath = [NSIndexPath indexPathForRow:inputColIndex inSection:inputRowIndex]; // actual format: [row , col]
        
        [self.gameEngine.currentPlayer setLastSelectedCell: inputIndexPath];
        if ([self.gameEngine didCurrentPlayerMakeValidMove]) {
            self.matrixLabel.text = [self.gameEngine gameBoardState];
            [self.gameEngine printBoardState];
            
            if ([self.gameEngine winningConditionsFulfiled]) {
                [self handleWin];
            } else if (![self.gameEngine hasFreeCells]) {
                [self handleDraw];
            } else {
                [self printCurrentPlayerSelection];
            }

            if (![self.gameEngine isGameOver]) [self.gameEngine switchCurrentPlayer];
                
            
//            if (![self.gameEngine isGameOver] &&  self.gameEngine.gameMode == GameModeOnePlayer && [self.gameEngine didCurrentPlayerMakeValidMove]) {
//                self.matrixLabel.text = [self.gameEngine gameBoardState];
//                [self.gameEngine printBoardState];
//                
//                if ([self.gameEngine winningConditionsFulfiled]) {
//                    [self handleWin];
//                } else if (![self.gameEngine hasFreeCells]) {
//                    [self handleDraw];
//                } else {
//                    [self printCurrentPlayerSelection];
//                    [self.gameEngine switchCurrentPlayer];
//                }
//            }
        } else {
            NSLog(@"Cell at %tu,%tu already selected! Please select another cell!", inputRowIndex, inputColIndex);
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
