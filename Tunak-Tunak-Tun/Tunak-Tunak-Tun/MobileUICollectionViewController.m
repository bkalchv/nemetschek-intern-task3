//
//  MobileUICollectionViewController.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 16.12.21.
//

#import "MobileUICollectionViewController.h"
#import "MobileUICollectionViewCell.h"
#import "OneMoreTimeViewController.h"
#import "Engine.h"
#import "Move.h"
#import "TicTacToeCellState.h"
#import "TunakTunakTunCellState.h"

@interface MobileUICollectionViewController ()
@end

@implementation MobileUICollectionViewController

static NSString * const reuseIdentifier = @"MobileUICollectionViewCell";

- (void)refreshView {
    
    switch ([GameConfigurationManager.sharedGameConfigurationManager gameMode]) {
        case GameModeOnePlayer: {
            Engine* engine = [[Engine alloc] initWithPlayersName: [GameConfigurationManager.sharedGameConfigurationManager player1Username]];
            engine.delegate = self;
            self.gameEngine = engine;
            break;
        }
        case GameModeTwoPlayers: {
            Engine* engine = [[Engine alloc] initWithPlayer1Name:[GameConfigurationManager.sharedGameConfigurationManager player1Username] player2Name:[GameConfigurationManager.sharedGameConfigurationManager player2Username]];
            engine.delegate = self;
            self.gameEngine = engine;
            break;
        }
 
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if (self.gameEngine.isGameOver || !self.gameEngine.hasFreeCells) [self refreshView];
    self.collectionView.allowsSelection = YES;
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.allowsMultipleSelection = YES;
}

- (void)handleWin {
    NSLog(@"%@ won!", [self.gameEngine currentPlayerName]);
    NSLog(@"Game over!");
    [self.delegate showPlayerWonAlert: [self.gameEngine currentPlayerName] withGameBoardState:[self.gameEngine gameBoardStateAsString]];
}

- (void)handleDraw {
    NSLog(@"It's a draw. Nobody wins!");
    [self.delegate showDrawAlert: [self.gameEngine gameBoardStateAsString]];
}

-(void)printCurrentPlayerMove:(Move*)move {
    NSLog(@"Player: %@ selected: %tu %tu", [self.gameEngine currentPlayerName], [move.indexPath section], [move.indexPath row]);
}

-(void)checkGameOutcomeForMove:(Move*)move {
    if ([self.gameEngine winningConditionsFulfiled]) {
        [self handleWin];
    } else if (![self.gameEngine winningConditionsFulfiled] && ![self.gameEngine hasFreeCells]) {
        [self handleDraw];
    } else {
        [self printCurrentPlayerMove:move];
    }
}

-(void)handleSelection:(NSIndexPath*)indexPath {
    
    Move *move = [self.gameEngine createMoveOfCurrentPlayer:indexPath];
    
    if ([self.gameEngine didCurrentPlayerCreateValidMove:move]) {
        [self.gameEngine handleValidMove:move];
        
        [self.collectionView reloadData];
        
        if (![self.gameEngine isGameOver]) {
            [self.gameEngine switchCurrentPlayerWithYourTurnBabySideEffect];
            [self.gameEngine emptyRedoStack];
            [self.delegate updateUsernameLabel:[self.gameEngine currentPlayerName]];
            if ([self.gameEngine isRedoStackEmpty]) [self.delegate disableRedoButton];
        }
        
    } else {
        NSLog(@"Cell at %tu,%tu already selected! Please select another cell!", [indexPath section], [indexPath row]);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // Stays for debugging purposes
    NSLog(@"I was pressed: %@", indexPath);
    
    NSUInteger inputIndex = [indexPath row];
    // section == indexAtPosition: 0 && row = indexAtPosition: 1 for indexPath, therefore swapped
    NSInteger row = [self.gameEngine calculateRowIndex:inputIndex];
    NSInteger col = [self.gameEngine calculateColumnIndex:inputIndex];
    NSIndexPath* inputIndexPath = [NSIndexPath indexPathForRow:col inSection:row];
    
    [self handleSelection: inputIndexPath];
    if (![self.gameEngine isUndoStackEmpty]) [self.delegate enableUndoButton];
    //[self.collectionView reloadData];
}

- (void)onUndoButtonClick {
    [self.gameEngine undo];
    
    if ([self.gameEngine gameMode] == GameModeOnePlayer) [self.gameEngine undo];
    [self.delegate updateUsernameLabel:[self.gameEngine currentPlayerName]];
    if ([self.gameEngine isUndoStackEmpty]) [self.delegate disableUndoButton];
    if (![self.gameEngine isRedoStackEmpty]) [self.delegate enableRedoButton];
    [self.collectionView reloadData];
}

- (void)onRedoButtonClick {
    [self.gameEngine redo];
    
    if ([self.gameEngine gameMode] == GameModeOnePlayer) [self.gameEngine redo];
    [self.delegate updateUsernameLabel:[self.gameEngine currentPlayerName]];
    if ([self.gameEngine isRedoStackEmpty]) [self.delegate disableRedoButton];
    if (![self.gameEngine isUndoStackEmpty]) [self.delegate enableUndoButton];
    [self.collectionView reloadData];
}

#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger cellsAmount = self.gameEngine.gameBoard.boardMatrixArray.count;
    return cellsAmount;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellWidth = (CGRectGetWidth(collectionView.frame) * 0.33); // 33% width of the CollectionView Frame
    CGFloat cellHeight = (CGRectGetHeight(collectionView.frame) * 0.33); // 33 height of the CollectionView Frame
    
    return CGSizeMake(cellWidth, cellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

-(NSString*)cellLabelTextByState:(NSInteger)integerOfState {
    switch([GameConfigurationManager.sharedGameConfigurationManager game]) {
        case GameTicTacToe: {
                switch (integerOfState) {
                    case TicTacToeCellStateO:
                        return @"O";
                        break;
                    case TicTacToeCellStateX:
                        return @"X";
                        break;
                    case TicTacToeCellStateEmpty:
                        return @"";
                        break;
                }
        }
            
                break;
                
        case GameTunakTunakTun: {
            switch (integerOfState) {
                case TunakCellStateGreen:
                    return @"g";
                    break;
                case TunakCellStateYellow:
                    return @"y";
                    break;
                case TunakCellStateRed:
                    return @"r";
                    break;
            }
        }
            
            
        default:
            break;
    }

    
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MobileUICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSIndexPath* cellIndexPath = [NSIndexPath indexPathForRow:[self.gameEngine calculateColumnIndex:indexPath.row] inSection:[self.gameEngine calculateRowIndex:indexPath.row]];
    Cell* gameCell = [self.gameEngine.gameBoard cellAt: cellIndexPath];
   
    switch ([GameConfigurationManager.sharedGameConfigurationManager game]) {
        case GameTicTacToe: {
            NSString* cellLabelText = [self cellLabelTextByState:gameCell.stateInteger];
            [cell.cellLabel setText: cellLabelText];
            [cell setBackgroundColor: UIColor.grayColor];
        }
            break;
        case GameTunakTunakTun: {
            //NSString* cellLabelText = [self cellLabelTextByState:gameCell.stateInteger];
            //[cell.cellLabel setText: cellLabelText];
            switch (gameCell.stateInteger) {
                case TunakCellStateEmpty:
                    [cell setBackgroundColor: UIColor.grayColor];
                    break;
                case TunakCellStateGreen:
                    [cell setBackgroundColor:UIColor.greenColor];
                    break;
                case TunakCellStateYellow:
                    [cell setBackgroundColor:UIColor.yellowColor];
                    break;
                case TunakCellStateRed:
                    [cell setBackgroundColor:UIColor.redColor];
                    break;
            }
            break;
        }

        default:
            break;
    }
   
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
 return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forIte- (void)encodeWithCoder:(nonnull NSCoder *)coder {
 <#code#>
 }
 
 - (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
 <#code#>
 }
 
 - (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
 <#code#>
 }
 
 - (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
 <#code#>
 }
 
 - (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
 <#code#>
 }
 
 - (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
 <#code#>
 }
 
 - (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
 <#code#>
 }
 
 - (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
 <#code#>
 }
 
 - (void)setNeedsFocusUpdate {
 <#code#>
 }
 
 - (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
 <#code#>
 }
 
 - (void)updateFocusIfNeeded {
 <#code#>
 }
 
 mAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
 
 }
 */

@end
