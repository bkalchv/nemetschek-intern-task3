//
//  ConsoleViewController.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "ConsoleViewController.h"
#import "OneMoreTimeViewController.h"
#import "Engine.h"
#import "Move.h"

@interface ConsoleViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *consoleVCEnterButton;
@property (weak, nonatomic) IBOutlet UILabel *matrixLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *undoButton;
@property (weak, nonatomic) IBOutlet UIButton *redoButton;
@end

@implementation ConsoleViewController

- (void)refreshView {
    switch ([GameConfigurationManager.sharedGameConfigurationManager gameMode]) {
        case GameModeOnePlayer: {
            Engine* engine = [[Engine alloc] initWithPlayersName: [GameConfigurationManager.sharedGameConfigurationManager player1Username]];
            engine.delegate = self;
            self.gameEngine = engine;
            [self.undoButton setEnabled:NO];
            [self.redoButton setEnabled:NO];
            break;
            
        }
            
        case GameModeTwoPlayers: {
            Engine* engine = [[Engine alloc] initWithPlayer1Name:[GameConfigurationManager.sharedGameConfigurationManager player1Username] player2Name: [GameConfigurationManager.sharedGameConfigurationManager player2Username]];
            engine.delegate = self;
            self.gameEngine = engine;
            [self.undoButton setEnabled:NO];
            [self.redoButton setEnabled:NO];
            break;
        }
            
        default:
            break;
    }
    
    self.usernameLabel.text = [NSString stringWithFormat:@"It's up to you, %@!", [self.gameEngine currentPlayerName]];
    self.consoleVCEnterButton.enabled = YES;
    self.matrixLabel.text = [self.gameEngine.gameBoard stateAsString];
    [self.gameEngine printBoardState];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self refreshView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch ([GameConfigurationManager.sharedGameConfigurationManager gameMode]) {
        case GameModeOnePlayer: {
            Engine* engine = [[Engine alloc] initWithPlayersName: [GameConfigurationManager.sharedGameConfigurationManager player1Username]];
            engine.delegate = self;
            self.gameEngine = engine;
            break;
        }

        case GameModeTwoPlayers: {
            Engine* engine = [[Engine alloc] initWithPlayer1Name:[GameConfigurationManager.sharedGameConfigurationManager player1Username] player2Name: [GameConfigurationManager.sharedGameConfigurationManager player2Username]];
            engine.delegate = self;
            self.gameEngine = engine;
            break;
        }
            
        default:
            break;
    }
    
    self.inputTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.usernameLabel.text = [NSString stringWithFormat:@"It's up to you, %@!", [self.gameEngine currentPlayerName]];
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
    UIAlertController* drawAlert = [UIAlertController alertControllerWithTitle: @"It's a draw!" message: [NSString stringWithString:self.gameEngine.gameBoard.stateAsString] preferredStyle:UIAlertControllerStyleAlert];
    [drawAlert addAction: [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        [self showOneMoreTimeViewController];
    } ]];
    [self presentViewController:drawAlert animated:YES completion:nil];
}

- (void)showPlayerWonAlert:(NSString*)playerName {
    UIAlertController* playerWonAlert = [UIAlertController alertControllerWithTitle: [NSString stringWithFormat:@"Player %@ won!", playerName] message: [NSString stringWithString:self.gameEngine.gameBoard.stateAsString] preferredStyle:UIAlertControllerStyleAlert];
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
    NSLog(@"%@ won!", [self.gameEngine currentPlayerName]);
    NSLog(@"Game over!");
    [self.consoleVCEnterButton setEnabled:NO];
    [self showPlayerWonAlert: [self.gameEngine currentPlayerName]];
}

- (void)handleDraw {
    NSLog(@"It's a draw. Nobody wins!");
    [self.consoleVCEnterButton setEnabled:NO];
    [self showDrawAlert];
}

-(void)printCurrentPlayerSelectionForMove:(Move*)move {
    NSLog(@"Player: %@ selected: %tu %tu", [self.gameEngine currentPlayerName], [move.indexPath section],  [move.indexPath row]);
}

-(void)checkGameOutcomeForMove:(Move*)move {
    if ([self.gameEngine winningConditionsFulfiled]) {
        [self handleWin];
    } else if (![self.gameEngine winningConditionsFulfiled] && ![self.gameEngine hasFreeCells]) {
        [self handleDraw];
    } else {
        [self printCurrentPlayerSelectionForMove:move];
    }
}

-(void)enableUndoButton {
    [self.undoButton setEnabled:YES];
}

-(void)disableUndoButton {
    [self.undoButton setEnabled:NO];
}

-(void)enableRedoButton {
    [self.redoButton setEnabled:YES];
}

-(void)disableRedoButton {
    [self.redoButton setEnabled:NO];
}

- (IBAction)onUndoButtonClick:(id)sender {
    [self.gameEngine undo];
    
    if ([self.gameEngine gameMode] == GameModeOnePlayer) [self.gameEngine undo];
    
    self.matrixLabel.text = [self.gameEngine gameBoardStateAsString];
    self.usernameLabel.text = [NSString stringWithFormat: @"It's up to you, %@!", [self.gameEngine currentPlayerName]];
    if ([self.gameEngine isUndoStackEmpty]) [self disableUndoButton];
    if (![self.gameEngine isRedoStackEmpty]) [self enableRedoButton];
}

- (IBAction)redoButtonClick:(id)sender {
    [self.gameEngine redo];
    
    if ([self.gameEngine gameMode] == GameModeOnePlayer) [self.gameEngine redo];
    
    self.matrixLabel.text = [self.gameEngine gameBoardStateAsString];
    self.usernameLabel.text = [NSString stringWithFormat: @"It's up to you, %@!", [self.gameEngine currentPlayerName]];
    if ([self.gameEngine isRedoStackEmpty]) [self disableRedoButton];
    if (![self.gameEngine isUndoStackEmpty]) [self enableUndoButton];
}

-(void)handleSelection:(NSIndexPath*)indexPath {
    Move* move = [self.gameEngine createMoveOfCurrentPlayer:indexPath];
    
    if ([self.gameEngine didCurrentPlayerCreateValidMove:move]) {
        [self.gameEngine handleValidMove:move];
        if ([self.gameEngine isRedoStackEmpty]) [self disableRedoButton];
        self.matrixLabel.text = [self.gameEngine gameBoardStateAsString];
        
        
        if (![self.gameEngine isGameOver])  {
            [self.gameEngine switchCurrentPlayerWithYourTurnBabySideEffect];
            self.usernameLabel.text = [NSString stringWithFormat: @"It's up to you, %@!", [self.gameEngine currentPlayerName]];
        }
    } else {
        NSLog(@"Cell at %tu,%tu already selected! Please select another cell!", [indexPath section], [indexPath row]);
    }
}


- (IBAction)onConsoleVCEnterButton:(id)sender {
    NSString* inputString = self.inputTextField.text;
    
    if ([self isValidInput:inputString]) {
        NSArray<NSString*>* inputArray = [inputString componentsSeparatedByString:@" "];
        NSUInteger inputRowIndex = [inputArray[0] integerValue];
        NSUInteger inputColIndex = [inputArray[1] integerValue];
        
        NSIndexPath* inputIndexPath = [NSIndexPath indexPathForRow:inputColIndex inSection:inputRowIndex]; // actual format: [row , col]
        [self handleSelection:inputIndexPath];
        if (![self.gameEngine isUndoStackEmpty]) [self.undoButton setEnabled:YES];
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
