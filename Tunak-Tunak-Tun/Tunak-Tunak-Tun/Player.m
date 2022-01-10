//
//  Player.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import "Player.h"
#import "Board.h"
#import "Move.h"
#import <UIKit/UIKit.h>

@interface Player ()
@property (nonatomic, strong) NSIndexPath* intendedCellIndexPath;
@end

@implementation Player

-(instancetype)initPlayerWithName:(NSString*)name withId:(NSUInteger)playerID withSign:(CellState)sign withBoard:(Board*)board {
    self = [super init];
    if (self) {
        self.name = name;
        self.playerID = playerID;
        self.sign = sign;
        self.board = board;
    }
    return self;
}

-(Move*)makeIntendedMove {
    Move* intendedMove = [[Move alloc] initWithPlayer:self withBoard:self.board];
    return intendedMove;
}

-(NSIndexPath*)intendedCellIndexPath {
    return _intendedCellIndexPath;
}

-(void)intendedCellIndexPathSetter:(NSIndexPath *)indexPath {
    _intendedCellIndexPath = indexPath;
}

-(void)yourTurnBaby
{
    // wait for input;
}

@end
