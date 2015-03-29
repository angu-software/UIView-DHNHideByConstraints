//
//  UIView+DHNHideByConstraints.h
//  HideViewByConstraints
//
//  Created by Andreas on 19.03.15.
//  Copyright (c) 2015 dreyhomenet. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Category to hide the view and its consuming space on its superview.
 */
@interface UIView (DHNHideByConstraints)

/**
 *  Hides or shows the view by changing its horizontal constraints and its subviews.
 *
 *  @param hide YES to hide the view, NO to show the view.
 */
- (void)hideHorizontal:(BOOL)hide;

/**
 *  Hides or shows the view by changing its vertical constraints and its subviews.
 *
 *  @param hide YES to hide the view, NO to show the view.
 */
- (void)hideVertical:(BOOL)hide;

@end
