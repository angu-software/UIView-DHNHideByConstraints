//
//  UIVibrancyEffect+DHNHideByConstraints.m
//  HideViewByConstraints
//
//  Created by Andreas on 19.03.15.
//  Copyright (c) 2015 dreyhomenet. All rights reserved.
//

#import "UIView+DHNHideByConstraints.h"
#import <objc/runtime.h>

@implementation UIView (DHNHideByConstraints)

- (NSMutableDictionary *)stateStorage {
    NSMutableDictionary *stateSorage = (NSMutableDictionary *)objc_getAssociatedObject(self, @selector(stateStorage));
    if (!stateSorage) {
        stateSorage = @{}.mutableCopy;
        objc_setAssociatedObject(self, @selector(stateStorage), stateSorage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return stateSorage;
}

- (NSArray *)horizontalConstraintAttributes {
    return @[@(NSLayoutAttributeWidth),
             @(NSLayoutAttributeLeading),
             @(NSLayoutAttributeTrailing),
             @(NSLayoutAttributeLeft),
             @(NSLayoutAttributeRight),
             @(NSLayoutAttributeTrailingMargin),
             @(NSLayoutAttributeLeadingMargin)];
}

- (NSArray *)verticalConstraintAttributes {
    return @[@(NSLayoutAttributeHeight),
             @(NSLayoutAttributeTop),
             @(NSLayoutAttributeBottom),
             @(NSLayoutAttributeTopMargin),
             @(NSLayoutAttributeBottomMargin)];
}

#pragma mark -

- (void)hideHorizontal:(BOOL)hide {
    [self hide:hide byAttributes:[self horizontalConstraintAttributes]];
}

- (void)hideVertical:(BOOL)hide {
    [self hide:hide byAttributes:[self verticalConstraintAttributes]];
}

#pragma mark -

- (void)hide:(BOOL)hide byAttributes:(NSArray *)attributes {
    if (self.hidden == hide) {
        return;
    }
    
    [self.subviews enumerateObjectsUsingBlock: ^(UIView *subView, NSUInteger idx, BOOL *stop) {
        [subView hide:hide byAttributes:attributes];
    }];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstAttribute IN %@ && self.class == %@", attributes, [NSLayoutConstraint class]];
    NSArray *constraints = [self.constraints filteredArrayUsingPredicate:predicate];
    
    [constraints enumerateObjectsUsingBlock: ^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        NSString *constraintKey = [NSString stringWithFormat:@"%p", constraint];
        CGFloat constantValue = NAN;
        if (hide) {
            self.stateStorage[constraintKey] = @(constraint.constant);
            constantValue = 0;
        }
        else {
            if (self.stateStorage[constraintKey]) {
                constantValue = [self.stateStorage[constraintKey] floatValue];
                [self.stateStorage removeObjectForKey:constraintKey];
            }
        }
        if (!isnan(constantValue)) {
            constraint.constant = constantValue;
        }
    }];
    
    self.hidden = hide;
}

@end
