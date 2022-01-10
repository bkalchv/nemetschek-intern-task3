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

-(Move*)makeMoveWithIndexPath:(NSIndexPath*)indexPath {
    Move* move = [[Move alloc] initWithIndexPath:indexPath withBoard:self.board];
    return move;
}
-(void)yourTurnBaby
{
    // wait for input;
}

@end
