//
//  MovesStack.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 7.01.22.
//

#import "MovesStack.h"

@interface MovesStack ()
@property (nonatomic, strong) NSMutableArray<Move*>* moves;
@end

@implementation MovesStack

- (instancetype)init {
    if (self = [self initWithArray: [[NSMutableArray<Move*> alloc] init]]) {}
    return self;
}

- (instancetype)initWithArray:(NSArray<Move*>*)array {
    if ((self = [super init])) {
        _moves = [[NSMutableArray alloc] initWithArray:array];
    }
    return self;
}

- (void)pushMove:(Move*)move {
    if (move != nil) {
        [_moves addObject:move];
    }
}

- (Move*)popObject {
    if ([_moves count] > 0) {
        NSUInteger lastObjectIndex = [_moves count] - 1;
        Move* moveOnTop = [_moves objectAtIndex:lastObjectIndex];
        [_moves removeLastObject];
        return moveOnTop;
    }
    
    return nil;
}

- (Move*)peekObject {
    if ([_moves count] > 0) {
        NSUInteger lastObjectIndex = [_moves count] - 1;
        Move* moveOnTop = [_moves objectAtIndex:lastObjectIndex];
        return moveOnTop;
    }
    
    return nil;
}

@end
