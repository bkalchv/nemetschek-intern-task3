//
//  MobileUIViewController.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 16.12.21.
//

#import "MobileUIViewController.h"
#import "Engine.h"
#import "MobileUICollectionViewController.h"
#import "MobileUICollectionViewCell.h"
#import "OneMoreTimeViewController.h"

@interface MobileUIViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mobileUIUsernameLabel;
@end

@implementation MobileUIViewController

- (void)refreshView {
    self.mobileUIUsernameLabel.text = [NSString stringWithFormat:@"It's up to you, %@!", [GameConfigurationManager.sharedGameConfigurationManager player1Username]];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self refreshView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mobileUIUsernameLabel.text = [NSString stringWithFormat:@"It's up to you, %@!", [GameConfigurationManager.sharedGameConfigurationManager player1Username]];
    // Do any additional setup after loading the view.
}

- (void)showAlreadySelectedAlertForCell:(Cell*)cell {
    UIAlertController* alreadySelectedAlert = [UIAlertController alertControllerWithTitle: [NSString stringWithFormat:@"Cell [%tu,%tu] has already been selected!", cell.rowIndex, cell.colIndex] message: @"Please, select another cell." preferredStyle:UIAlertControllerStyleAlert];
    [alreadySelectedAlert addAction: [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler: nil]];
    [self presentViewController:alreadySelectedAlert animated:YES completion:nil];
}

- (void)showDrawAlert:(NSString*)gameBoardState {
    UIAlertController* drawAlert = [UIAlertController alertControllerWithTitle: @"It's a draw!" message: [NSString stringWithString: gameBoardState] preferredStyle:UIAlertControllerStyleAlert];
    [drawAlert addAction: [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        [self showOneMoreTimeViewController];
    } ]];
    [self presentViewController:drawAlert animated:YES completion:nil];
}

- (void)showPlayerWonAlert:(Player*)player withGameBoardState:(NSString*)gameBoardState {
    UIAlertController* playerWonAlert = [UIAlertController alertControllerWithTitle: [NSString stringWithFormat:@"Player %@ won!", player.name] message: [NSString stringWithString: gameBoardState] preferredStyle:UIAlertControllerStyleAlert];
    [playerWonAlert addAction: [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        [self showOneMoreTimeViewController];
    } ]];
    [self presentViewController:playerWonAlert animated:YES completion:nil];
}


- (void)showOneMoreTimeViewController {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OneMoreTimeViewController* oneMoreTimeViewController = [storyboard instantiateViewControllerWithIdentifier:@"OneMoreTimeViewController"];
    self.presentationController.delegate = self;
    [self presentViewController:oneMoreTimeViewController animated:YES completion:nil];
}

- (void)updateUsernameLabel:(NSString*) currentPlayerUsername {
    [self.mobileUIUsernameLabel setText:  [NSString stringWithFormat:@"It's up to you, %@!", currentPlayerUsername]];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"ShowMobileUICollectionView"]) {
        MobileUICollectionViewController* mobileUICollectionViewController = [segue destinationViewController];
        mobileUICollectionViewController.delegate = self;
        switch ([GameConfigurationManager.sharedGameConfigurationManager gameMode]) {
            case GameModeOnePlayer: {
                Engine* engine = [[Engine alloc] initWithPlayersName:[GameConfigurationManager.sharedGameConfigurationManager player1Username]];
                engine.delegate = mobileUICollectionViewController;
                mobileUICollectionViewController.gameEngine = engine;
                break;
            }

            case GameModeTwoPlayers: {
                Engine* engine = [[Engine alloc] initWithPlayer1Name:[GameConfigurationManager.sharedGameConfigurationManager player1Username] player2Name:[GameConfigurationManager.sharedGameConfigurationManager player2Username]];
                engine.delegate = mobileUICollectionViewController;
                mobileUICollectionViewController.gameEngine = engine;
                break;
            }
                
            default:
                break;
        }
    }
}


@end
