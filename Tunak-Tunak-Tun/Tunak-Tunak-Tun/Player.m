//
//  Player.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "Player.h"
#import "Board.h"
#import <UIKit/UIKit.h>

@interface Player ()
@end

@implementation Player
// init with board
-(instancetype)initPlayerWithName:(NSString*)name withId:(NSUInteger)playerID withSign:(CellState)sign {
    self = [super init];
    if (self) {
        self.name = name;
        self.playerID = playerID;
        self.sign = sign;
    }
    return self;
}

-(void)markForDeath:(NSIndexPath *)indexPath
{
    self.lastSelectedCell = indexPath;
}

//remove board param

-(void)makeMoveOnBoard:(Board*)board {
    NSUInteger lastSelectedCellRowIndex = [self.lastSelectedCell section];
    NSUInteger lastSelectedCellColIndex = [self.lastSelectedCell row];
    [board changeCellStateAtRowIndex:lastSelectedCellRowIndex  columnIndex:lastSelectedCellColIndex withSign:self.sign];
}

-(void)setLastSelectedCell:(NSIndexPath *)lastSelectedCell {
    _lastSelectedCell = lastSelectedCell;
}

//-(void)yourTurnBaby
//{
//    // nothing
//}

@end
