//
//  Board.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <Foundation/Foundation.h>
#import "TunakCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface Board : NSObject
@property (nonatomic, strong) NSMutableArray<NSMutableArray<TunakCell*>*>* boardMatrix;
@property (nonatomic) NSUInteger numberOfRows;
@property (nonatomic) NSUInteger numberOfColumns;
- (instancetype)initWithRows:(NSUInteger)rowsAmount;
- (void)printRow:(NSUInteger)row;
- (void)printState;
@end

NS_ASSUME_NONNULL_END
