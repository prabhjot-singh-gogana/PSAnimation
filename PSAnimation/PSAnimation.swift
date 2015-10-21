//
//  PSAnimation.swift
//  TestAndCheck_Swift
//
//  Created by prabhjot singh on 10/6/15.
//  Copyright (c) 2015 prabhjot singh. All rights reserved.
//

import UIKit

typealias MovingIndexBlock = (index:Int) -> Void

var closureMovingIndex = MovingIndexBlock!()

// class which convert angle into radian
private  func degreesToRadian(x:CGFloat)->CGFloat
{
    return ( (x) * 3.1415 / 180)
}


public class PSBasicAnimation: NSObject {

    enum AxisType {
        case XAxisType
        case YAxisType
    }
    
    

///////////- - -- -- - -- - - -- - -ROTAION --- - - -- - -- - - -- - ////////

// Rotate to any angle with jerk
    
    class func rotateTheViewWithFlex(view: UIView, withDuration duration:NSTimeInterval, andWithDegrees degree:CGFloat)
    {
        
        UIView.animateWithDuration(0.3, delay: 0, options:[], animations:
            {
                view.transform = CGAffineTransformRotate(view.transform, degreesToRadian(-5))
                
            }, completion:
            {finished in
                
                if finished
                {
                    self.rotateTheView(view, withDuration: duration, andWithDegrees: degree + 5)
                }
        })
    }
    
// Rotate to any angle without jerk
    
    class func rotateTheView(view: UIView, withDuration duration:NSTimeInterval, andWithDegrees degree:CGFloat)
    {
        
        UIView.animateWithDuration(duration, delay: 0, options:[], animations:
            {
                view.transform = CGAffineTransformRotate(view.transform, degreesToRadian(degree))
                
            }, completion:
            {finished in
                
                if !finished
                {
                    self.rotateTheViewWithFlex(view, withDuration: duration, andWithDegrees: degree)
                }
        })
    }
    
// Rotate to any angle with jerk  using Blocks
    
    class func rotateTheViewWithFlex(view: UIView, withDuration duration:NSTimeInterval, andWithDegrees degree:CGFloat, withBlock block:() -> Void , completionBlock completedBlock:() -> Void)
    {
        UIView.animateWithDuration(0.3, delay: 0, options:[], animations:
            {
                view.transform = CGAffineTransformRotate(view.transform, degreesToRadian(-5))
                block()
                
            }, completion:
            {finished in
                
                if finished
                {
                    UIView.animateWithDuration(duration, delay: 0, options:[], animations:
                        {
                            view.transform = CGAffineTransformRotate(view.transform, degreesToRadian(degree))
                            
                        }, completion:
                        {finished in
                            
                            if !finished
                            {
                                self.rotateTheViewWithFlex(view, withDuration: duration, andWithDegrees: degree)
                            }
                            else
                            {
                                completedBlock();
                            }
                    })
                }
        })
    }
    
// Rotate to any angle without jerk  using Blocks
    
    class func rotateTheView(view: UIView, withDuration duration:NSTimeInterval, andWithDegrees degree:CGFloat, withBlock block:() -> Void , completionBlock completedBlock:() -> Void)
    {
        UIView.animateWithDuration(duration, delay: 0, options:[], animations:
            {
                view.transform = CGAffineTransformRotate(view.transform, degreesToRadian(degree))
                block()
                
            }, completion:
            {finished in
                
                if !finished
                {
                    self.rotateTheViewWithFlex(view, withDuration: duration, andWithDegrees: degree)
                }
                else
                {
                    completedBlock();
                }
        })
    }
    

///////////- - -- -- - -- - - -- - - BASIC ANIMATION --- - - -- - -- - - -- - ////////
    
// Use for vibrate or shake the view
    class func shakeTheView(view: UIView, withDuration duration:NSTimeInterval, andWithRepeat repeatCount:NSInteger)
    {
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount =  Float(repeatCount)
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(view.center.x - 3, view.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(view.center.x + 3, view.center.y))
        view.layer.addAnimation(animation, forKey: "position")
        
    }
    
// Use for delete the view
    class func animateTheViewLikeDelete(view:UIView, withComplettion completionBlock:(complete:Bool)->Void)
    {
        let viewsToAnimate = [view]
        UIView.performSystemAnimation(UISystemAnimation.Delete, onViews: viewsToAnimate, options: [], animations: {
            }, completion: { finished in
                completionBlock(complete: finished)
        })
    }
    
    
    
}


///////////- - -- -- - -- - - -- - - TRANSITION ANIMATION OF IMAGES --- - - -- - -- - - -- - ////////
    
// GLOBAL Variable
    
// params: imageViews is an mutable array of UIviews and UIImages
// params: transitionOption is UIViewAnimationOptions defaultly it will be TransitionCrossDissolve
// params: transitDuration is the time taken by the trasition of view
// params: transitDuration is the time taken by the trasition of view
// params: transitIndex is the index of view added which are added in imageViews array
    
public class PSViewsAnimation: NSObject {
    
    public var imageViews:NSMutableArray = []
        {
        didSet
        {
            let imagesArray:NSMutableArray = []
            for view in imageViews
            {
                let someView:NSObject = view as! NSObject
                if someView.isKindOfClass(UIImage)
                {
                    let image:UIImage = someView as! UIImage
                    let imageView:UIImageView = UIImageView(image:image)
                    imageView.frame = transitView.bounds
                    imageView.contentMode = UIViewContentMode.ScaleAspectFit
                    imagesArray.addObject(imageView)
                }
                else
                {
                    imagesArray.addObject(someView)
                }
            }
            self.imageViews.removeAllObjects()
            self.imageViews = imagesArray
            
            let pictureView:UIView = self.imageViews[self.transitIndex] as! UIView
            self.transitView.addSubview(pictureView)
        }
    }
    
    public var transitionOption = UIViewAnimationOptions.TransitionCrossDissolve
    public var transitDuration:NSTimeInterval = 0.0
    
    public var transitIndex:Int = 0
        {
        didSet{
            self.removeAlltheViews()
            let pictureView:UIView = self.imageViews[self.transitIndex] as! UIView
            self.transitView.addSubview(pictureView)
        }}
    public var transitView:UIView = UIView()
    private var shouldGoNext:Bool = true
    

    
    func animateTheViews(container: UIView, withDuration duration:NSTimeInterval, andWithTransitionOption transitionOptions:UIViewAnimationOptions, withCompletion movingIndexBlock:MovingIndexBlock)
    {
        
        self.transitDuration = duration
        self.transitionOption = transitionOptions
        self.transitView = container
        closureMovingIndex = movingIndexBlock
        
        if imageViews.count >= 2
        {
            self.removeAlltheViews()
            let pictureView:UIView = self.imageViews[self.transitIndex] as! UIView
            pictureView.frame = self.transitView.bounds
            self.transitView.addSubview(pictureView)
            closureMovingIndex(index: self.transitIndex)
            
        }else
        {
            print("imageView count must be greated than 2")
        }
    }
    

    private func transitTheViews(transition:UIViewAnimationOptions)
    {
        if imageViews.count >= 2
        {
            self.removeAlltheViews()
            
            UIView.transitionWithView(self.transitView, duration:self.transitDuration, options:transition , animations: {
                
                var nextIndex:Int = 0
                
                var pictureView:UIView
                if self.shouldGoNext == true
                {
                    nextIndex = self.transitIndex + 1
                }
                else
                {
                    nextIndex = self.transitIndex - 1
                }
                    
                pictureView = self.imageViews[nextIndex] as! UIView
                pictureView.frame = self.transitView.bounds
                self.transitView.addSubview(pictureView)
                
                if self.shouldGoNext == true
                {  self.transitIndex++ }
                else
                { self.transitIndex-- }
                
                closureMovingIndex(index: nextIndex)
                
                }, completion:nil
            )
        }
        else
        {
            print("imageView count must be greated than 2")
        }
    }
    
    
    func goToNextView()
    {
        shouldGoNext = true
        if (imageViews.count-1) > transitIndex
        {
            self.transitTheViews(self.transitionOption)
            
        }
    }
    
    func goToPreviousView()
    {
        shouldGoNext = false
        if transitIndex != 0
        {
            self.transitTheViews(self.oppositeTranstion(self.transitionOption))
        }
    }

    private func removeAlltheViews()
    {
        let subViews = self.transitView.subviews
        for subview in subViews{
            subview.removeFromSuperview()
        }
    }
    
    func oppositeTranstion(transition:UIViewAnimationOptions) -> UIViewAnimationOptions
    {
        switch transition {
            case UIViewAnimationOptions.TransitionNone:
                return UIViewAnimationOptions.TransitionNone
            
            case UIViewAnimationOptions.TransitionFlipFromRight:
                return UIViewAnimationOptions.TransitionFlipFromLeft
            
            case UIViewAnimationOptions.TransitionFlipFromLeft:
                return UIViewAnimationOptions.TransitionFlipFromRight
            
            case UIViewAnimationOptions.TransitionCurlUp:
                return UIViewAnimationOptions.TransitionCurlDown
            
            case UIViewAnimationOptions.TransitionCurlDown:
                return UIViewAnimationOptions.TransitionCurlUp
            
            case UIViewAnimationOptions.TransitionCrossDissolve:
                return UIViewAnimationOptions.TransitionCrossDissolve
            
            case UIViewAnimationOptions.TransitionFlipFromTop:
                return UIViewAnimationOptions.TransitionFlipFromBottom
            
            case UIViewAnimationOptions.TransitionFlipFromBottom:
                return UIViewAnimationOptions.TransitionFlipFromTop
            
            default:
                return UIViewAnimationOptions.TransitionNone
        }
    }
    

    
}
    


///////////- - -- -- - -- - - -- - - PATTREN ANIMATION OF IMAGE --- - - -- - -- - - -- - ////////

// GLOBAL Variable

// params: bgColor is used to set the background color of the view
// params: patternImage is an image of pattern
// params: animating is bool variable which can be handled user by true or false




public class PSPattrenAnimation: UIView
{
    public var bgColor:UIColor = UIColor()
        {didSet{self.backgroundColor = bgColor}}
    
    private var imgPatternView:UIImageView? = UIImageView()
    public var patternImage:UIImage? = UIImage()
    {
        didSet
        {
            self.imgPatternView = UIImageView(image: patternImage)
            self.addSubview(imgPatternView!)
            self.sendSubviewToBack(imgPatternView!)
        }
    }
    public var animating:Bool = Bool()
    
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        self.awakeFromNib()
        
    }
    
    override public func layoutSubviews() {
        if self.frame.size.width == self.imgPatternView!.frame.size.width{
            return
        }
        super.layoutSubviews()
        var tempFrame:CGRect = self.imgPatternView!.frame
        tempFrame.size.width = self.frame.size.width
        self.imgPatternView!.frame = tempFrame
    }
    
     override public func awakeFromNib() {
        self.imgPatternView = UIImageView()
        self.addSubview(imgPatternView!)
        self.sendSubviewToBack(imgPatternView!)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"didBecomeActive", name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func didBecomeActive()
    {
        if (self.animating)
        {
            let tempFrame:CGRect = self.imgPatternView!.frame
            self.imgPatternView?.frame = CGRectMake(tempFrame.origin.x, 0, tempFrame.size.width, tempFrame.size.height)
            self.startPatternViewAnimation()
        }
    }
    
    public func removePattren() {
        self.imgPatternView!.removeFromSuperview()
        self.imgPatternView = nil
    }
    
    public func startPatternViewAnimation(){
        
        
        if (self.imgPatternView?.image != nil)
        {
            self.clipsToBounds = true
            self.animating = true
            
            UIView.animateWithDuration(100, delay:0, options:[UIViewAnimationOptions.CurveLinear, UIViewAnimationOptions.Repeat] , animations: { () -> Void in
                var tempFrame:CGRect = self.imgPatternView!.frame
                tempFrame.origin.y = self.frame.size.height - self.imgPatternView!.frame.size.height
                self.imgPatternView!.frame = tempFrame
                
                }, completion: nil)
        }
        else
        {
            print("must have any one pattern image", terminator: "")
        }
    }
    

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
        self.imgPatternView = nil
    }
    
}

