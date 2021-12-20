//
//  MobileUICollectionViewController.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 16.12.21.
//

#import <UIKit/UIKit.h>
#import "Engine.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MobileUICollectionViewControllerDelegate <NSObject>
- (void) selectCell:(NSIndexPath*)selectedCellIndexPath;
@end

@interface MobileUICollectionViewController : UICollectionViewController <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) Engine* gameEngine;
@property (nonatomic, strong)id <MobileUICollectionViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
