![alt tag](https://github.com/prabhjot-singh-gogana/PSAnimation/blob/master/ezgif.com-video-to-gif.gif)
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
###PSViewsAnimation
Animate the collections of views(UIView) and Images(UIImage) with different styles.

**Types of transition styles**

psAnimation.transitionOption = UIViewAnimationOptions.TransitionNone

Following are the styles of Transitions -

    - TransitionNone
    - TransitionFlipFromLeft
    - TransitionFlipFromRight
    - TransitionCurlUp
    - TransitionCurlDown
    - TransitionCrossDissolve
    - TransitionFlipFromTop
    - TransitionFlipFromBottom
    
```
var psAnimation = PSViewsAnimation()
override func viewDidLoad() {
        super.viewDidLoad()
// arrayOfImages is the array which collects images and views
        psAnimation.imageViews = arrayOfImages
        psAnimation.transitIndex = 0
        psAnimation.animateTheViews(view, withDuration: 1, andWithTransitionOption: UIViewAnimationOptions.TransitionNone , withCompletion: { (viewIndex) -> Void in // viewIndex is index of visible view
            if viewIndex == 0
            {
                //do anything
            }
        })

// Used to change the current view to next view
@IBAction func next() {
        self.psAnimation.goToNextView()
    }
// Used to change the current view to previous view
@IBAction func previous() {
        self.psAnimation.goToPreviousView()
    }
```
###PSPattrenAnimation
Pattren animation is use to animate the image or pattren of background view.
There are two ways to create the pattren animation.

**Through Nib File**

`@IBOutlet var animatedBGView:PSPattrenAnimation?`

- In Xib file create the UIView make the outlet with animatedBGView
- In the right-hand sidebar, click on the third tab--the one that looks a bit like a newspaper
- Under "Custom Class" at the top, make sure Class is the name of the UIView that should be PSPattrenAnimation .

```
        animatedBGView!.bgColor = UIColor.whiteColor()
        animatedBGView?.patternImage = UIImage(named: "pattern2.png")
        animatedBGView!.startPatternViewAnimation()
```
**Through Programming**

```
override func viewDidLoad() {
        super.viewDidLoad()
        let pattrenView:PSPattrenAnimation = PSPattrenAnimation()
        pattrenView.frame = self.view.bounds
        pattrenView.bgColor = UIColor.lightGrayColor()
        pattrenView.patternImage = UIImage(named: "pattern.png")
        self.view.addSubview(pattrenView)
        }
```
