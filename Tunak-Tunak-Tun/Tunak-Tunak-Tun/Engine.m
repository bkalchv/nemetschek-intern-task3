//
//  Engine.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "Engine.h"
#import "Cell.h"
#import "Move.h"
#import "MovesStack.h"
#import <UIKit/UIKit.h>

@interface Engine()
@property (nonatomic, strong) Player* currentPlayer;
@property (nonatomic, strong) Player* player1;
@property (nonatomic, strong) Player* player2;
@property (nonatomic) NSUInteger freeCellsAmount;
@property (nonatomic, strong) MovesStack* undoStack;
@property (nonatomic, strong) MovesStack* redoStack;
@end

@implementation Engine

-(instancetype) init {
    self = [super init];
    if (self) {
        self.gameBoard = [[Board alloc] initWithRows:3];
        self.freeCellsAmount = 9;
        self.hasFreeCells = YES;
        self.winningConditionsFulfiled = NO;
    }
    return self;
}

- (instancetype)initWithPlayersName:(NSString*)playersName {
    self = [self init];
    if (self) {
        self.gameMode = GameModeOnePlayer;
        self.player1 = [[Player alloc] initPlayerWithName:playersName withId:1 withSign:CellStateX withBoard:self.gameBoard];
        Bot* bot = [[Bot alloc] initWithSign:CellStateO withBoard:self.gameBoard];
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
        self.gameMode = GameModeTwoPlayers;
        self.player1 = [[Player alloc] initPlayerWithName:player1Name withId:1 withSign:CellStateX withBoard:self.gameBoard];
        self.player2 = [[Player alloc] initPlayerWithName:player2Name withId:2 withSign:CellStateO withBoard:self.gameBoard];
        self.currentPlayer = self.player1;
        self.undoStack = [[MovesStack alloc] init];
        self.redoStack = [[MovesStack alloc] init];
    }
    return self;
}

- (void)printBoardState {
    [self.gameBoard printState];
}

-(NSString*)currentPlayerName {
    return [self.currentPlayer name];
}

- (Move*)makeMoveOfCurrentPlayer:(NSIndexPath*)indexPath {
    return [self.currentPlayer makeMoveWithIndexPath:indexPath];
}

- (NSString*)gameBoardState {
    return [self.gameBoard stateString];
}

- (BOOL)checkColumnForCellSelection:(Cell*)cell withSign:(CellState)sign {
    for (size_t i = 0; i < self.gameBoard.numberOfColumns; i++) {
        if ([self.gameBoard cellAtRowIndex:cell.rowIndex columnIndex:i].state != sign) break;
        if (i + 1 == self.gameBoard.numberOfColumns) return true;
    }
    return false;
}

-(BOOL)checkRowForCellSelection:(Cell*)cell withSign:(CellState)sign {
    for (size_t i = 0; i < self.gameBoard.numberOfRows; i++) {
        if ([self.gameBoard cellAtRowIndex:i columnIndex:cell.colIndex].state != sign) break;
        if (i + 1 == self.gameBoard.numberOfRows) return true;
    }
    return false;
}

-(BOOL)checkDiagonalForCellSelection:(Cell*)cell withSign:(CellState)sign {
    if(cell.rowIndex == cell.colIndex) {
        for(int i = 0; i < self.gameBoard.numberOfRows; i++) {
            if([self.gameBoard cellAtRowIndex:i columnIndex:i].state != sign) break;
            if(i + 1 == self.gameBoard.numberOfRows) return true;
        }
    }
    return false;
}

-(BOOL)checkAntiDiagonalForCellSelection:(Cell*)cell withSign:(CellState)sign {
    if(cell.rowIndex + cell.colIndex + 1 == self.gameBoard.numberOfRows) {
        for(int i = 0; i < self.gameBoard.numberOfRows; i++) {
            if([self.gameBoard cellAtRowIndex:i columnIndex:(self.gameBoard.numberOfRows - 1 - i)].state != sign) break;
            if(i + 1 == self.gameBoard.numberOfRows) return true;
        }
    }
    return false;
}

- (BOOL)areWinningConditionsFulfilledForSelectionOfCellAt:(NSIndexPath*)cellIndexPath withSign:(CellState)sign {
    Cell* cell = [self.gameBoard cellAt:cellIndexPath];
    return [self checkColumnForCellSelection:cell withSign:sign] || [self checkRowForCellSelection:cell withSign:sign] || [self checkDiagonalForCellSelection:cell withSign:sign] || [self checkAntiDiagonalForCellSelection:cell withSign:sign];
}

- (BOOL)isCellChecked:(NSIndexPath*)indexPath {
    return [[self.gameBoard cellAt:indexPath] isChecked];
}

-(void)switchCurrentPlayerWithYourTurnBabySideEffect {
    [self switchCurrentPlayer];
    [self.currentPlayer yourTurnBaby];
}

-(void)switchCurrentPlayer{

    if (self.currentPlayer == self.player1) {

        self.currentPlayer = self.player2;
        
        return;

    } else if (self.currentPlayer == self.player2) {
        
        self.currentPlayer = self.player1;
        
        return;

    } else NSLog(@"Engine obj, switchCurrentPlayer: undefined behavior");
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

- (BOOL)areWinningConditionsFulfilledOnPlayerMove:(Move*)move {
    return [self areWinningConditionsFulfilledForSelectionOfCellAt:move.indexPath withSign: self.currentPlayer.sign];
}

- (void)updateGameEngineStateOnPlayerMove:(Move*)move {
    self.freeCellsAmount = [self.gameBoard calculateFreeCellsAmount];
    self.hasFreeCells = (self.freeCellsAmount != 0);
    self.winningConditionsFulfiled = [self areWinningConditionsFulfilledOnPlayerMove:move];
}

- (void)updateGameEngineStateOnGameBoardStateChange {
    self.freeCellsAmount = [self.gameBoard calculateFreeCellsAmount];
    self.hasFreeCells = (self.freeCellsAmount != 0);
}

-(BOOL)didCurrentPlayerMakeValidMove:(Move*)move {
    return [move isValidMove];
}

-(void)emptyRedoStack {
    while (![self isRedoStackEmpty]) {
        [self.redoStack pop];
    }
}

-(void)handleValidMove:(Move*)move {
    NSUInteger moveRow = [move.indexPath section];
    NSUInteger moveColumn = [move.indexPath row];
    [self.gameBoard changeCellStateAtRowIndex:moveRow columnIndex:moveColumn withSign:[self.currentPlayer sign]];
    // legit?
    [self.undoStack pushMove:move];
    [self updateGameEngineStateOnPlayerMove:move];
    [self printBoardState];
    // legit?
    [self emptyRedoStack];
    
    [self.delegate checkGameOutcomeForMove:move];
}

-(void)handleSelection:(NSIndexPath *)indexPath {
    [self.delegate handleSelection:indexPath];
}

-(void)deselectCellAtIndexPath:(NSIndexPath*)indexPath {
    [self.gameBoard deselectCellAtIndexPath:indexPath];
}

-(void)selectCellAtIndexPath:(NSIndexPath*)indexPath withSign:(CellState)sign {
    NSUInteger row = [indexPath section];
    NSUInteger col = [indexPath row];
    [self.gameBoard changeCellStateAtRowIndex:row columnIndex:col withSign:sign];
}

-(void)undoLastMove:(Move*)move {
    [self deselectCellAtIndexPath: [move indexPath]];
}

-(void)redoLastMove:(Move*)move {
    [self selectCellAtIndexPath:[move indexPath] withSign:[self.currentPlayer sign]];
}

-(void)undo {
    Move* undoStackTopMove = [self.undoStack peek];
    if (undoStackTopMove != nil) {
        [self.redoStack pushMove: undoStackTopMove];
        [self undoLastMove: undoStackTopMove];
        // Stays for debuging purposes
        //NSLog(@"After Undo:\n");
        //[self printBoardState];
        [self updateGameEngineStateOnGameBoardStateChange];
        [self.undoStack pop];
        [self switchCurrentPlayer];
    }

}

-(void)redo {
    Move* redoStackTopMove = [self.redoStack peek];
    if (redoStackTopMove != nil) {
        [self.undoStack pushMove:redoStackTopMove];
        [self redoLastMove: redoStackTopMove];
        [self updateGameEngineStateOnGameBoardStateChange];
        [self.redoStack pop];
        [self switchCurrentPlayer];
    }
}

- (BOOL)isUndoStackEmpty {
    return self.undoStack.count == 0;
}

- (BOOL)isRedoStackEmpty {
    return self.redoStack.count == 0;
}


@end
