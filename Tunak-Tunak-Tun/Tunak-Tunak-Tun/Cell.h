//
//  Cell.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 13.12.21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CellState) {
    CellStateX,
    CellStateO,
    CellStateEmpty
};

@interface Cell : NSObject
@property (nonatomic) CellState state;
@property (nonatomic) NSUInteger rowIndex;
@property (nonatomic) NSUInteger colIndex;
- (instancetype)initWithState:(CellState)state atRow:(NSUInteger)row atColumn:(NSUInteger)col;
- (NSString*)description;
- (BOOL)isChecked;
@end


NS_ASSUME_NONNULL_END
