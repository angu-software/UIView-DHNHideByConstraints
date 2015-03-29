# UIView+DHNHideByConstraints

This category on UIView hides views and its consuming vertical or horizontal space in the view hierarchy. This also affects the views subviews.

# How to use

## Set up

You can install this category by using cocoapods or manually copy the source files to your project.

To install with cocoapods simply add this line to yout Podfile.

```
pod 'DHNHideByConstraints', :git =>'https://github.com/dreyhomedev/UIView-DHNHideByConstraints.git'
```

## Hide Views

To use this category simply import the ```UIView+DHNHideByConstraints.h``` and call ether ```hideVertical:``` or ```hideHorizontal:``` on the view you would like to hide.

```
#import "UIView+DHNHideByConstraints.h"
...

- (void)hideViews {

[self.myViewToHide1 hideVertical:YES];
[self.myViewToHide2 hideHorizontal:YES];

}

- (void)showViews {

[self.myViewToHide1 hideVertical:NO];
[self.myViewToHide2 hideHorizontal:NO];

}

```

## Limitations

When using this category make sure you do not alter the content of the views (and its subviews) when hidden. This can cause unexpected effects on the views layout, especial on UILabel, UIButton ect.
If you must change the content of the hidden view, unhide it first, change its content and hide again.
