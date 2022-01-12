//
//  OneMoreTimeViewController.m
//  Tunak-Tunak-Tun
//
//  Created by Bogdan Kalchev on 14.12.21.
//

#import "OneMoreTimeViewController.h"

@implementation OneMoreTimeViewController
- (IBAction)onOneMoreTimeVCYesButton:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^(void){
        [self.delegate dismissPresentingViewController];
    }];
}

- (IBAction)onOneMoreTimeVCNoButtonClick:(id)sender {
    UIAlertController* alertAppWillClose = [UIAlertController alertControllerWithTitle: @"Okay, then! Until next time!" message: @"The application will close after hitting the OK button" preferredStyle:UIAlertControllerStyleAlert];
    [alertAppWillClose addAction: [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        exit(0);
    }]];
    
    [self presentViewController:alertAppWillClose animated:YES completion:nil];
}

@end
