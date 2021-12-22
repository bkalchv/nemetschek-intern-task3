//
//  Engine.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "Engine.h"
#import "Cell.h"

@interface Engine()
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
        self.player1 = [[Player alloc] initPlayerWithName:playersName withId:1 withSign:CellStateX];
        self.player2 = [[Player alloc] initPlayerWithName:@"CPU" withId:2 withSign:CellStateO];
        self.currentPlayer = self.player1;
    }
    return self;
}

- (instancetype)initWithPlayer1Name:(NSString*)player1Name player2Name:(NSString*)player2Name {
    self = [self init];
    if (self) {
        self.gameMode = GameModeTwoPlayers;
        self.player1 = [[Player alloc] initPlayerWithName:player1Name withId:1 withSign:CellStateX];
        self.player2 = [[Player alloc] initPlayerWithName:player2Name withId:2 withSign:CellStateO];
        self.currentPlayer = self.player1;
    }
    return self;
}

- (void)printBoardState {
    [self.gameBoard printState];
}

- (NSString*)gameBoardState {
    return [self.gameBoard stateString];
}

- (void)changeCellStateAtRowIndex:(NSUInteger)rowIndex atColumnIndex:(NSUInteger)columnIndex toState:(CellState)state {
    [[self.gameBoard cellAtRowIndex:rowIndex columnIndex:columnIndex] setState:state];
}

- (void)changeCellStateAtIndex:(NSUInteger)index toState:(CellState)state {
    [[self.gameBoard.boardMatrixArray objectAtIndex:index] setState:state];
}

- (void)selectCellAtRowIndex:(NSUInteger)rowIndex atColumnIndex:(NSUInteger)columnIndex byPlayer:(Player*)player {
    [player makeMoveOnBoard:[self gameBoard] atRowIndex:rowIndex columnIndex:columnIndex];
    [self updateGameEngineStateOnPlayerSelectionOfCellAtRowIndex:rowIndex columnIndex:columnIndex];
}

- (void)selectCellAtRowIndex:(NSUInteger)rowIndex atColumnIndex:(NSUInteger)columnIndex {
    [self selectCellAtRowIndex:rowIndex atColumnIndex:columnIndex byPlayer:self.currentPlayer];
}

- (void)selectCellAtIndex:(NSUInteger)index byPlayer:(Player *)player{
    [player makeMoveOnBoard:[self gameBoard] atIndex:index];
    [self updateGameEngineStateOnPlayerSelectionOfCellAtIndex:index];
}


- (void)selectCellAtIndex:(NSUInteger)index {
    [self selectCellAtIndex:index byPlayer:self.currentPlayer];
}

-(NSUInteger)randomIndex:(NSUInteger)maxIndex {
    NSUInteger lowerBoundIndex = 0;
    NSUInteger upperBoundIndex = maxIndex;
    NSUInteger randomIndex = lowerBoundIndex + arc4random() % (upperBoundIndex - lowerBoundIndex + 1);
    return randomIndex;
}

//TODO: - use a separate collection for the free cells instead of recursice calls to random (calculated property
-(NSArray<Cell*> *)freeCells {
    NSMutableArray<Cell*>* freeCellsArray = [[NSMutableArray<Cell*> alloc] init];
    for (Cell* cell in self.gameBoard.boardMatrixArray) {
        if (!cell.isChecked) [freeCellsArray addObject:cell];
    }
    return freeCellsArray;
}

-(Cell*)randomFreeCell{
    NSArray<Cell*>* freeCells = [self freeCells];
    return [freeCells objectAtIndex: [self randomIndex:([freeCells count] - 1)] ];
}

- (Cell*)CPUSelects {
    if (self.hasFreeCells) {
        Cell* CPUCellToSelect = [self randomFreeCell];
        [self selectCellAtRowIndex:CPUCellToSelect.rowIndex atColumnIndex:CPUCellToSelect.colIndex byPlayer: self.currentPlayer];
        [self setCurrentPlayer:self.player1];
        return CPUCellToSelect;
    } else return nil;
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

- (BOOL)areWinningConditionsFulfilledForSelectionOfCell:(Cell*)cell withSign:(CellState)sign {
    return [self checkColumnForCellSelection:cell withSign:sign] || [self checkRowForCellSelection:cell withSign:sign] || [self checkDiagonalForCellSelection:cell withSign:sign] || [self checkAntiDiagonalForCellSelection:cell withSign:sign];
}

- (Cell*)cellAtIndex:(NSUInteger)index {
    return [self.gameBoard cellAtIndex:index];
}

- (BOOL)isCellCheckedAtRowIndex:(NSUInteger)rowIndex columnIndex:(NSUInteger)columnIndex {
    return [[[self gameBoard] cellAtRowIndex:rowIndex columnIndex:columnIndex] isChecked];
}

- (BOOL)isCellCheckedAtIndex:(NSUInteger)index {
    return [[[self gameBoard] cellAtIndex:index] isChecked];
}

-(void)switchCurrentPlayer{

    if (self.currentPlayer == self.player1) {

        self.currentPlayer = self.player2;
        
        if (self.gameMode == GameModeOnePlayer) {
            [self CPUSelects];
        }

    } else if (self.currentPlayer == self.player2) {
        
        self.currentPlayer = self.player1;
    
    } else NSLog(@"Engine obj, switchCurrentPlayer: undefined behavior");
}

- (BOOL)isGameOver {
    return self.winningConditionsFulfiled || !self.hasFreeCells;
}


- (void)updateGameEngineStateOnPlayerSelectionOfCellAtRowIndex:(NSUInteger)rowIndex columnIndex:(NSUInteger)columnIndex{
    Cell* selectedCell = [self.gameBoard cellAtRowIndex:rowIndex columnIndex:columnIndex];
    self.freeCellsAmount -= 1;
    NSLog(@"%tu", [self freeCellsAmount]);
    self.hasFreeCells = (self.freeCellsAmount != 0);
    
    if ([self areWinningConditionsFulfilledForSelectionOfCell:selectedCell withSign: self.currentPlayer.sign])
    {
        self.winningConditionsFulfiled = YES;
        NSLog(@"%@ won!", self.currentPlayer.name);
        NSLog(@"Game over!");
        return;
    } else {
        NSLog(@"Player: %tu selected: %tu %tu", self.currentPlayer.playerID, rowIndex, columnIndex);
    }
}


- (void)updateGameEngineStateOnPlayerSelectionOfCellAtIndex:(NSUInteger)index {
    Cell* selectedCell = [self.gameBoard cellAtIndex:index];
    self.freeCellsAmount -= 1;
    NSLog(@"%tu", [self freeCellsAmount]);
    self.hasFreeCells = (self.freeCellsAmount != 0);
    
    if ([self areWinningConditionsFulfilledForSelectionOfCell:selectedCell withSign:self.currentPlayer.sign])
    {
        self.winningConditionsFulfiled = YES;
        NSLog(@"%@ won!", self.currentPlayer.name);
        NSLog(@"Game over!");
        return;
    } else {
        NSLog(@"Player: %tu selected: %tu %tu", self.currentPlayer.playerID, [selectedCell rowIndex], [selectedCell colIndex]);
    }
}

@end
