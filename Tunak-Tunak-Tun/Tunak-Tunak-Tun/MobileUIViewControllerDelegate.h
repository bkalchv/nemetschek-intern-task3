//
//  MobileUIViewControllerDelegate.h
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 10.01.22.
//

#ifndef MobileUIViewControllerDelegate_h
#define MobileUIViewControllerDelegate_h

@protocol MobileUIViewControllerDelegate <NSObject>
-(void)onUndoButtonClick;
-(void)onRedoButtonClick;
@end

#endif /* MobileUIViewControllerDelegate_h */
