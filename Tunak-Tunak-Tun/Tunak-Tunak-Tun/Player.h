//
//  Player.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <Foundation/Foundation.h>
#import "Cell.h"

NS_ASSUME_NONNULL_BEGIN

@interface Player : NSObject
@property NSUInteger playerID;
@property (nonatomic, strong) NSString* name;
//@property (nonatomic, strong) NSMutableSet<Cell*>* selectedCells;
@property (nonatomic) CellState sign;
-(instancetype)initPlayerWithName:(NSString*)name withId:(NSUInteger)playerId withSign:(CellState)sign;
@end

NS_ASSUME_NONNULL_END
