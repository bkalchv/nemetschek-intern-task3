//
//  Engine.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "Engine.h"
#import "Cell.h"
#import "Move.h"
#import <UIKit/UIKit.h>

@interface Engine()
@property (nonatomic, strong) Player* currentPlayer;
@property (nonatomic, strong) Player* player1;
@property (nonatomic, strong) Player* player2;
@property (nonatomic) NSUInteger freeCellsAmount;
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
    }
    return self;
}

- (void)printBoardState {
    [self.gameBoard printState];
}

-(NSString*)currentPlayerName {
    return [self.currentPlayer name];
}

- (NSIndexPath*)currentPlayerIntendedCellIndexPath {
    return [self.currentPlayer intendedCellIndexPath];
}

- (void)setCurrentPlayerIntendedCellIndexPath:(NSIndexPath*)indexPath {
    [self.currentPlayer setIntendedCellIndexPath:indexPath];
}

- (Move*)makeIntendedMoveOfCurrentPlayer {
    return [self.currentPlayer makeIntendedMove];
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

-(void)switchCurrentPlayer{

    if (self.currentPlayer == self.player1) {

        self.currentPlayer = self.player2;

    } else if (self.currentPlayer == self.player2) {
        
        self.currentPlayer = self.player1;

    } else NSLog(@"Engine obj, switchCurrentPlayer: undefined behavior");
    
    [self.currentPlayer yourTurnBaby];
    //if ([self.currentPlayer.name isEqualToString:@"CPU"] && self.gameMode == GameModeOnePlayer) [self updateGameEngineStateOnPlayerMove];
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

//delegate win/loss

- (BOOL)areWinningConditionsFulfilledOnPlayerMove {
    return [self areWinningConditionsFulfilledForSelectionOfCellAt:[self.currentPlayer intendedCellIndexPath] withSign: self.currentPlayer.sign];
}

- (void)updateGameEngineStateOnPlayerMove {
    // TODO: make it calculated
    self.freeCellsAmount = [self.gameBoard calculateFreeCellsAmount];
    self.hasFreeCells = (self.freeCellsAmount != 0);
    self.winningConditionsFulfiled = [self areWinningConditionsFulfilledOnPlayerMove];
}

- (BOOL)isValidMove {
    Cell* lastSelectedCell = [self.gameBoard cellAt:[self.currentPlayer intendedCellIndexPath]];
    return !lastSelectedCell.isChecked;
}

-(BOOL)didCurrentPlayerMakeValidMove {
    if ([self isValidMove] && ![self.currentPlayer.name isEqualToString:@"CPU"]) {
        [self updateGameEngineStateOnPlayerMove];

        return YES;
    }

    return NO;
}

-(BOOL)didCurrentPlayerMakeValidMove:(Move*)move {
    return [move isValidMove];
}

-(void)handleValidMove:(Move*)move {
    NSUInteger moveRow = [move.player.intendedCellIndexPath section];
    NSUInteger moveColumn = [move.player.intendedCellIndexPath row];
    [self.gameBoard changeCellStateAtRowIndex:moveRow columnIndex:moveColumn withSign:[self.currentPlayer sign]];
    [self updateGameEngineStateOnPlayerMove];
    [self printBoardState];
    [self.delegate checkGameOutcome];
}

-(void)handleSelection:(NSIndexPath *)indexPath {
    [self.delegate handleSelection:indexPath];
}

@end
