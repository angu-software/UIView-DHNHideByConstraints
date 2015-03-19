//
//  DHNExampleViewController.m
//  HideViewByConstraints
//
//  Created by Andreas on 19.03.15.
//  Copyright (c) 2015 dreyhomenet. All rights reserved.
//

#import "DHNExampleViewController.h"
#import "UIView+DHNHideByConstraints.h"

@interface DHNExampleViewController ()

@property (strong, nonatomic) IBOutlet UIView *viewToHide;

@end

@implementation DHNExampleViewController

- (IBAction)hideHorizontalAction:(id)sender {
    [self.viewToHide hideByHeight:!self.viewToHide.hidden];
    
    if (self.viewToHide.hidden) {
        [sender setTitle:@"ShowHorizontal" forState:UIControlStateNormal];
    } else {
        [sender setTitle:@"HideHorizontal" forState:UIControlStateNormal];
    }
}

- (IBAction)hideVerticalAction:(UIButton *)sender {
    [self.viewToHide hideByWidth:!self.viewToHide.hidden];
    
    if (self.viewToHide.hidden) {
        [sender setTitle:@"ShowVertical" forState:UIControlStateNormal];
    } else {
        [sender setTitle:@"HideVertical" forState:UIControlStateNormal];
    }
    
}

@end
