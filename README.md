
# PSAnimation
A library to simplify iOS animations in Swift.
##Installation
Drop in the PSAnimation.swift to your Xcode project (make sure to enable "Copy items if needed" and "Create groups").
##Usage
PSAnimation is a collection of animation in Swift examples for iOS apps
###PSBasicAnimation
All of the methods are class methods. Developers can easly animate the view just with one line
####Shake or Vibrate the view
`PSBasicAnimation.shakeTheView(view, withDuration: 0.07, andWithRepeat: 4)`
####Delete the view with remove animation
`PSBasicAnimation.animateTheViewLikeDelete(imgPerson, withComplettion: { (complete) -> Void in
            })`
####Rotation of View
**Rotate to any angle with jerk**

`PSBasicAnimation.rotateTheViewWithFlex(view, withDuration:0.7, andWithDegrees: CGFloat(sliderForAngle.value))`
**with Block**
```
PSBasicAnimation.rotateTheViewWithFlex(view, withDuration:0.7, andWithDegrees: CGFloat(sliderForAngle.value), withBlock: { () -> Void in
}, completionBlock: { () -> Void in
})
```
**Rotate to any angle**

`PSBasicAnimation.rotateTheView(view, withDuration:0.7, andWithDegrees: CGFloat(sliderForAngle.value))`
**with Block**
```
PSBasicAnimation.rotateTheView(view, withDuration:0.7, andWithDegrees: CGFloat(sliderForAngle.value), withBlock: { () -> Void in
}, completionBlock: { () -> Void in
})
```
