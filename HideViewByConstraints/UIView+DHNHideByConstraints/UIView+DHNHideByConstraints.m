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

#pragma mark -

- (void)hideByWidth:(BOOL)hide
{
    [self hide:hide bySizeAttribute:NSLayoutAttributeWidth];
}

- (void)hideByHeight:(BOOL)hide
{
    [self hide:hide bySizeAttribute:NSLayoutAttributeHeight];
}

#pragma mark -

- (void)hide:(BOOL)hide bySizeAttribute:(NSLayoutAttribute)attribute
{
    if (self.hidden == hide) {
        return;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstItem = %@ && firstAttribute == %d", self, attribute];
    NSLayoutConstraint *heightConstraint = [self.constraints filteredArrayUsingPredicate:predicate].firstObject;
    
    NSString *consraintKey = [NSString stringWithFormat:@"%p",heightConstraint];
    CGFloat constantValue = NAN;
    if (hide) {
        self.stateStorage[consraintKey] = @(heightConstraint.constant);
        constantValue = 0;
    } else {
        if (self.stateStorage[consraintKey]) {
            constantValue = [self.stateStorage[consraintKey] floatValue];
            [self.stateStorage removeObjectForKey:consraintKey];
        }
    }
    heightConstraint.constant = constantValue;
    self.hidden = hide;
}

@end
