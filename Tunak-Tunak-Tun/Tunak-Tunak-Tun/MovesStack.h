//
//  MovesStack.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 7.01.22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Move;

@interface MovesStack : NSObject

@property (nonatomic, assign, readonly) NSUInteger count;

- (id)initWithArray:(NSArray<Move*>*)array;
- (void)pushMove:(Move*)move;
- (id)popObject;
- (id)peekObject;

@end
NS_ASSUME_NONNULL_END
