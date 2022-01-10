//
//  Move.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 6.01.22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Board;
@class Player;

@interface Move : NSObject
-(instancetype)initWithIndexPath:(NSIndexPath*)indexPath withBoard:(Board*)board;
-(BOOL) isValidMove;
-(NSIndexPath*)indexPath;
@end

NS_ASSUME_NONNULL_END
