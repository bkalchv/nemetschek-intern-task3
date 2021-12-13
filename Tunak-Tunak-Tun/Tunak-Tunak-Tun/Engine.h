//
//  Engine.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <Foundation/Foundation.h>
#import "Board.h"
#import "Player.h"

NS_ASSUME_NONNULL_BEGIN

@interface Engine : NSObject
@property (nonatomic, strong) Board* gameBoard;
@property (nonatomic, strong) NSSet<Player*>* players;
- (instancetype)init;
- (void)printBoardState;
@end

NS_ASSUME_NONNULL_END
