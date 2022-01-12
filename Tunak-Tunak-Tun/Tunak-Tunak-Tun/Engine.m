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
    // legit? look up your notes ;)
    [self makeMove:move];
    [self.undoStack pushMove:move];
    [self printBoardState];
    [self.delegate checkGameOutcomeForMove:move];
}

-(void)handleSelection:(NSIndexPath *)indexPath {
    [self.delegate handleSelection:indexPath];
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

-(void)switchCurrentPlayerWithYourTurnBabySideEffect {
    //legit? idea tho?
    [self switchCurrentPlayer];
    [self.currentPlayer yourTurnBaby];
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
    // TODO: legit?
    return [self areWinningConditionsFulfilledForSelectionOfCellAt:move.indexPath withSign:move.sign];
    // vs
    // return [self areWinningConditionsFulfilledForSelectionOfCellAt:move.indexPath withSign:self.currentPlayer.sign];
}

- (void)updateGameEngineStateOnGameBoardStateChange {
    self.freeCellsAmount = [self.gameBoard calculateFreeCellsAmount];
    self.hasFreeCells = (self.freeCellsAmount != 0);
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

-(void)makeMove:(Move *)move {
    NSUInteger row = [move.indexPath section];
    NSUInteger col = [move.indexPath row];
    [self.gameBoard changeCellStateAtRowIndex:row columnIndex:col withSign:[move sign]];
    [self updateGameEngineStateOnPlayerMove:move];
    // if ([self gameMode] == GameModeOnePlayer) [self.undoStack pushMove:move];
    // TODO: legit? switchPlayer here?
}

// TODO: move->opposite
-(void)undoLastMove {
    Move* undoStackTop = [self.undoStack pop];
    [self makeMove: undoStackTop.opposite];
    [self.redoStack pushMove: undoStackTop];
    [self updateGameEngineStateOnGameBoardStateChange];
    [self switchCurrentPlayer];
}
    // [self deselectCellAtIndexPath: [lastMove indexPath]];

-(void)redoLastMove {
    Move* redoStackTop = [self.redoStack pop];
    [self makeMove: redoStackTop];
    [self.undoStack pushMove: redoStackTop];
    [self updateGameEngineStateOnPlayerMove:redoStackTop];
    [self switchCurrentPlayer];
}
    //[self selectCellAtIndexPath:[lastMove indexPath] withSign:[lastMove sign]];


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
