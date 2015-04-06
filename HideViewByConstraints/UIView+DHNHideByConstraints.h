//
//  UIView+DHNHideByConstraints.h
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
