//
//  UIVibrancyEffect+DHNHideByConstraints.m
//  HideViewByConstraints
//
//  Created by Andreas on 19.03.15.
//  Copyright (c) 2015 dreyhomenet. All rights reserved.
//

#import "UIView+DHNHideByConstraints.h"
#import <objc/objc-runtime.h>

@implementation UIView (DHNHideByConstraints)

- (NSMutableDictionary *)stateStorage
{

   NSMutableDictionary *stateSorage = (NSMutableDictionary *)objc_getAssociatedObject(self, @selector(stateStorage));
    if (!stateSorage) {
        stateSorage = @{}.mutableCopy;
        objc_setAssociatedObject(self, @selector(stateStorage), stateSorage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return stateSorage;
    
}

- (NSArray *)horizontalConstraintAttributes
{
    return @[@(NSLayoutAttributeWidth),
             @(NSLayoutAttributeLeading),
             @(NSLayoutAttributeTrailing),
             @(NSLayoutAttributeLeft),
             @(NSLayoutAttributeRight)];
}

- (NSArray *)verticalConstraintAttributes
{
    return @[@(NSLayoutAttributeHeight),
             @(NSLayoutAttributeTop),
             @(NSLayoutAttributeBottom)];
}

#pragma mark -

- (void)hideHorizontal:(BOOL)hide
{
    [self hide:hide byAttributes:[self horizontalConstraintAttributes]];
}

- (void)hideVertical:(BOOL)hide
{
    [self hide:hide byAttributes:[self verticalConstraintAttributes]];
}

#pragma mark -

- (void)hide:(BOOL)hide byAttributes:(NSArray *)attributes
{
    if (self.hidden == hide) {
        return;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(firstItem = %@ || secondItem = %@) && firstAttribute IN %@", self, self, attributes];
    NSArray *constraints = [self.constraints filteredArrayUsingPredicate:predicate];
    
    [constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *constraint, NSUInteger idx, BOOL *stop) {
        NSString *consraintKey = [NSString stringWithFormat:@"%p",constraint];
        CGFloat constantValue = NAN;
        if (hide) {
            self.stateStorage[consraintKey] = @(constraint.constant);
            constantValue = 0;
        } else {
            if (self.stateStorage[consraintKey]) {
                constantValue = [self.stateStorage[consraintKey] floatValue];
                [self.stateStorage removeObjectForKey:consraintKey];
            }
        }
        constraint.constant = constantValue;
    }];
    
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        [subView hide:hide byAttributes:attributes];
    }];
    
    self.hidden = hide;
}

@end
