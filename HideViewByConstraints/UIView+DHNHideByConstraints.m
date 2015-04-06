//
//  UIView+DHNHideByConstraints.m
//  HideViewByConstraints
//
//  Created by Andreas on 19.03.15.
//
//  The MIT License (MIT) (https://www.tldrlegal.com/l/mit)
//  Copyright (c) 2015 Andreas Guenther.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.

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
    
    if (self.constraints.count == 0) {
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
    
    [self.subviews enumerateObjectsUsingBlock: ^(UIView *subView, NSUInteger idx, BOOL *stop) {
        [subView hide:hide byAttributes:attributes];
    }];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstAttribute IN %@", attributes];
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
