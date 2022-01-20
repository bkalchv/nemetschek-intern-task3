//
//  Player.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 18.01.22.
//

#import "Player.h"
#import "Move.h"
#import "TicTacToeComponents/TicTacToeCellState.h"
#import "TunakTunakTunCellState.h"
#import "GameConfigurationManager.h"

@interface Player()
@property (nonatomic, strong) NSDictionary* tunakStateDictionary;
@end

@implementation Player

-(instancetype)initPlayerWithName:(NSString*)name withId:(NSUInteger)playerID withIntegerOfSign:(NSInteger)integerOfSign withBoard:(Board*)board {
    self = [super init];
    if (self) {
        self.name = name;
        self.playerID = playerID;
        self.integerOfSign = integerOfSign;
        self.board = board;
        self.tunakStateDictionary = @{
            @"r" : @(TunakCellStateRed),
            @"y" : @(TunakCellStateYellow),
            @"g" : @(TunakCellStateGreen)
        };
    }
    return self;
}

-(Move*)createMoveWithIndexPath:(NSIndexPath*)indexPath {
    Move* move = [[Move alloc] initWithIndexPath:indexPath withBoard:self.board withIntegerOfSign:self.integerOfSign];
    return move;
}


-(NSInteger)signIntegerValue:(NSString*)signAsString { // we're sure of the NSString format, because of the validation in the VC-er
    switch ([GameConfigurationManager.sharedGameConfigurationManager game]) {
        case GameTicTacToe: {
            NSLog(@"Not implemented yet, but needed!");
            return -1; // TODO: maybe not good
            break;
        }
        case GameTunakTunakTun: {
            NSNumber* signAsNSNumber = [self.tunakStateDictionary valueForKey:signAsString];
            return [signAsNSNumber integerValue];
            break;
        }
    }
    
    return -1;
}

-(Move*)createMoveWithIndexPath:(NSIndexPath*)indexPath withSign:(NSString*)signAsString {
    NSInteger integerOfString = [self signIntegerValue:signAsString];
    if (integerOfString == -1) return nil;
    Move* move = [[Move alloc] initWithIndexPath:indexPath withBoard:self.board withIntegerOfSign:integerOfString];
    return move;
}

-(void)yourTurnBaby
{
    // wait for input;
}
@end
