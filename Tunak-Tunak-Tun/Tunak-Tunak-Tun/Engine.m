//
//  Engine.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "Engine.h"
#import "TicTacToeCellState.h"
#import "TunakTunakTunCellState.h"
#import "Move.h"
#import "MovesStack.h"
#import "Player.h"
#import "Bot.h"
#import <UIKit/UIKit.h>

@interface Engine()
@property (nonatomic, strong) Player* currentPlayer;
@property (nonatomic, strong) Player* player1;
@property (nonatomic, strong) Player* player2;
@property (nonatomic, strong) MovesStack* undoStack;
@property (nonatomic, strong) MovesStack* redoStack;
@end

@implementation Engine

-(instancetype) init {
    self = [super init];
    if (self) {
        self.gameBoard = [[Board alloc] initWithRows:3];
        //self.freeCellsAmount = 9;
        self.hasFreeCells = YES;
        self.winningConditionsFulfiled = NO;
    }
    return self;
}

-(NSUInteger)randomIndex:(NSUInteger)maxIndex {
    NSUInteger lowerBoundIndex = 0;
    NSUInteger upperBoundIndex = maxIndex;
    NSUInteger randomIndex = lowerBoundIndex + arc4random() % (upperBoundIndex - lowerBoundIndex + 1);
    return randomIndex;
}

- (instancetype)initWithPlayersName:(NSString*)playersName {
    self = [self init];
    if (self) {
        self.gameMode = GameModeOnePlayer;
        self.player1 = [[Player alloc] initPlayerWithName:playersName withId:1 withIntegerOfSign:(NSInteger)TicTacToeCellStateX withBoard:self.gameBoard];
        
        Bot* bot;
        switch ([GameConfigurationManager.sharedGameConfigurationManager game]) {
            case GameTicTacToe: {
                bot = [[Bot alloc] initWithIntegerOfSign:(NSInteger)TicTacToeCellStateO withBoard:self.gameBoard];
                break;
            }
            case GameTunakTunakTun: {
                bot = [[Bot alloc] initWithIntegerOfSign:[self randomIndex:TunakCellStateCount] withBoard:self.gameBoard];
                break;
            }

            default:
                break;
        }
        
        bot.delegate = self;
        self.player2 = bot;
        self.currentPlayer = self.player1;
        self.undoStack = [[MovesStack alloc] init];
        self.redoStack = [[MovesStack alloc] init];
    }
    return self;
}

- (instancetype)initWithPlayer1Name:(NSString*)player1Name player2Name:(NSString*)player2Name {
    self = [self init];
    if (self) {
        
        
        Player* player1;
        Player* player2;
        
        switch ([GameConfigurationManager.sharedGameConfigurationManager game]) {
            case GameTicTacToe:
                player1 = [[Player alloc] initPlayerWithName:player1Name withId:1 withIntegerOfSign:TicTacToeCellStateX withBoard:self.gameBoard];
                player2 = [[Player alloc] initPlayerWithName:player2Name withId:2 withIntegerOfSign:TicTacToeCellStateO withBoard:self.gameBoard];
                break;
            case GameTunakTunakTun: {
                player1 = [[Player alloc] initPlayerWithName:player1Name withId:1 withIntegerOfSign:TunakCellStateGreen withBoard:self.gameBoard];
                player2 = [[Player alloc] initPlayerWithName:player2Name withId:2 withIntegerOfSign:TunakCellStateGreen withBoard:self.gameBoard];
                break;
            }

            default:
                break;
        }
        
        self.gameMode = GameModeTwoPlayers;
        self.player1 = player1;
        self.player2 = player2;
        self.currentPlayer = self.player1;
        self.undoStack = [[MovesStack alloc] init];
        self.redoStack = [[MovesStack alloc] init];
    }
    return self;
}

- (NSString*)gameBoardStateAsString {
    return [self.gameBoard stateAsString];
}

- (void)printBoardState {
    [self.gameBoard printState];
}

-(NSString*)currentPlayerName {
    return [self.currentPlayer name];
}

- (Move*)createMoveOfCurrentPlayer:(NSIndexPath*)indexPath {
    return [self.currentPlayer createMoveWithIndexPath:indexPath];
}

-(BOOL)didCurrentPlayerCreateValidMove:(Move*)move {
    return [move isValidMove];
}

-(void)handleValidMove:(Move*)move {
    [self makeMove:move];
    [self.undoStack pushMove:move];
    [self printBoardState];
    [self.delegate checkGameOutcomeForMove:move];
}

-(void)handleSelection:(NSIndexPath *)indexPath {
    [self.delegate handleSelection:indexPath];
}

-(void)switchCurrentPlayer {

    if (self.currentPlayer == self.player1) {

        self.currentPlayer = self.player2;
        
        return;

    } else if (self.currentPlayer == self.player2) {
        
        self.currentPlayer = self.player1;
        
        return;

    } else NSLog(@"Engine obj, switchCurrentPlayer: undefined behavior");
}

-(void)switchCurrentPlayerWithYourTurnBabySideEffect {
    [self switchCurrentPlayer];
    [self.currentPlayer yourTurnBaby];
}

- (BOOL)checkColumnForCellSelection:(Cell*)cell withSignInteger:(NSInteger)signInteger {
    for (size_t i = 0; i < self.gameBoard.numberOfColumns; i++) {
        if ([self.gameBoard cellAtRowIndex:cell.rowIndex columnIndex:i].stateInteger != signInteger) break;
        if (i + 1 == self.gameBoard.numberOfColumns) return true;
    }
    return false;
}

-(BOOL)checkRowForCellSelection:(Cell*)cell withSignInteger:(NSInteger)signInteger {
    for (size_t i = 0; i < self.gameBoard.numberOfRows; i++) {
        if ([self.gameBoard cellAtRowIndex:i columnIndex:cell.colIndex].stateInteger != signInteger) break;
        if (i + 1 == self.gameBoard.numberOfRows) return true;
    }
    return false;
}

-(BOOL)checkDiagonalForCellSelection:(Cell*)cell withSignInteger:(NSInteger)signInteger {
    if(cell.rowIndex == cell.colIndex) {
        for(int i = 0; i < self.gameBoard.numberOfRows; i++) {
            if([self.gameBoard cellAtRowIndex:i columnIndex:i].stateInteger != signInteger) break;
            if(i + 1 == self.gameBoard.numberOfRows) return true;
        }
    }
    return false;
}

-(BOOL)checkAntiDiagonalForCellSelection:(Cell*)cell withSignInteger:(NSInteger)signInteger {
    if(cell.rowIndex + cell.colIndex + 1 == self.gameBoard.numberOfRows) {
        for(int i = 0; i < self.gameBoard.numberOfRows; i++) {
            if([self.gameBoard cellAtRowIndex:i columnIndex:(self.gameBoard.numberOfRows - 1 - i)].stateInteger != signInteger) break;
            if(i + 1 == self.gameBoard.numberOfRows) return true;
        }
    }
    return false;
}

- (BOOL)areWinningConditionsFulfilledForSelectionOfCellAt:(NSIndexPath*)cellIndexPath withSignInteger:(NSInteger)signInteger { // game-specific
    Cell* cell = [self.gameBoard cellAt:cellIndexPath];
    return [self checkColumnForCellSelection:cell withSignInteger:signInteger] || [self checkRowForCellSelection:cell withSignInteger:signInteger] || [self checkDiagonalForCellSelection:cell withSignInteger:signInteger] || [self checkAntiDiagonalForCellSelection:cell withSignInteger:signInteger];
}

- (BOOL)isGameOver {
    return self.winningConditionsFulfiled || !self.hasFreeCells;
}

- (NSInteger)calculateRowIndex:(NSInteger)index {
    return index / [self.gameBoard numberOfColumns];
}

- (NSInteger)calculateColumnIndex:(NSInteger)index {
    return index % [self.gameBoard numberOfColumns];
}

- (BOOL)areWinningConditionsFulfilledOnPlayerMove:(Move*)move { // engine specific
    return [self areWinningConditionsFulfilledForSelectionOfCellAt:move.indexPath withSignInteger:move.integerOfSign];
}

- (void)updateGameEngineStateOnGameBoardStateChange {
    NSUInteger freeCellsAmount = [self.gameBoard freeCellsAmount];
    self.hasFreeCells = (freeCellsAmount != 0);
}


- (void)updateGameEngineStateOnPlayerMove:(Move*)move {
    [self updateGameEngineStateOnGameBoardStateChange];
    self.winningConditionsFulfiled = [self areWinningConditionsFulfilledOnPlayerMove:move];
}

-(void)emptyRedoStack {
    while (![self isRedoStackEmpty]) {
        [self.redoStack pop];
    }
}

-(void)makeMove:(Move *)move { // game specific
    NSUInteger row = [move.indexPath section];
    NSUInteger col = [move.indexPath row];
    [self.gameBoard changeCellStateAtRowIndex:row columnIndex:col withIntegerOfSign:[move integerOfSign]];
    [self updateGameEngineStateOnPlayerMove:move];
}

-(void)undoLastMove {
    Move* undoStackTop = [self.undoStack pop];
    [self makeMove: undoStackTop.opposite];
    [self.redoStack pushMove: undoStackTop];
    [self updateGameEngineStateOnGameBoardStateChange];
    [self switchCurrentPlayer];
}

-(void)redoLastMove {
    Move* redoStackTop = [self.redoStack pop];
    [self makeMove: redoStackTop];
    [self.undoStack pushMove: redoStackTop];
    [self updateGameEngineStateOnPlayerMove:redoStackTop];
    [self switchCurrentPlayer];
}


- (BOOL)isUndoStackEmpty {
    return self.undoStack.count == 0;
}

- (BOOL)isRedoStackEmpty {
    return self.redoStack.count == 0;
}

-(void)undo {
    if (![self isUndoStackEmpty]) {
        [self undoLastMove];
    }
}

-(void)redo {
    if (![self isRedoStackEmpty]) {
        [self redoLastMove];
    }
}

@end
