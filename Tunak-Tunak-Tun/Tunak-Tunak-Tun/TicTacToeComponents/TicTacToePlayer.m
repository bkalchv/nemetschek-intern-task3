////
////  Player.m
////  Tunak-Tunak-Tun
////
////  Created by Bogdan Kalchev on 13.12.21.
////
//
//#import "TicTacToePlayer.h"
//#import "Board.h"
//#import "Move.h"
//#import <UIKit/UIKit.h>
//
//@implementation TicTacToePlayer
//
//-(instancetype)initPlayerWithName:(NSString *)name withId:(NSUInteger)playerId withIntegerOfSign:(NSInteger)integerOfSign withBoard:(Board *)board {
//    self = [super initPlayerWithName:name withId:playerId withIntegerOfSign:integerOfSign withBoard:board];
//    if (self) {
//        self.sign = (TicTacToeCellState)self.integerOfSign;
//    }
//    return self;
//}
//
////-(instancetype)initPlayerWithName:(NSString*)name withId:(NSUInteger)playerID withSign:(TicTacToeCellState)sign withBoard:(Board*)board {
////    self = [super init];
////    if (self) {
////        self.name = name;
////        self.playerID = playerID;
////        self.sign = sign;
////        self.board = board;
////    }
////    return self;
////}
//
//-(Move*)createMoveWithIndexPath:(NSIndexPath*)indexPath {
//    Move* move = [[Move alloc] initWithIndexPath:indexPath withBoard:self.board withIntegerOfSign:self.integerOfSign];
//    return move;
//}
//
//-(void)yourTurnBaby
//{
//    // wait for input;
//}
//
//@end
