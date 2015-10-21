import UIKit

class AnimationViewController: UIViewController {
    
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet weak var imgPerson: UIImageView!
    @IBOutlet weak var container: UIView!
    @IBOutlet var animatedBGView:PSPattrenAnimation?
    @IBOutlet var viewWithDeleteView:UIView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var lblTransitions: UILabel!
    @IBOutlet var sliderForAngle: UISlider!
    @IBOutlet var lblAngle: UILabel!
    
    
    
    let blueSquare = UIView()
    var psAnimation = PSViewsAnimation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.blueSquare.frame = self.container.bounds
        self.blueSquare.backgroundColor = UIColor.blueColor()
        let designer:PSPattrenAnimation = PSPattrenAnimation()
        
        let arrayOfImages:NSMutableArray = []
        for i in 0..<6
        {
            if i == 3
            {
                arrayOfImages.addObject(viewWithDeleteView)
                continue
            }
            else if i == 0
            {
                
                designer.frame = container.bounds
                designer.bgColor = UIColor.lightGrayColor()
                designer.patternImage = UIImage(named: "pattern.png")
                arrayOfImages.addObject(designer)
                continue
            }
            
            let image:UIImage = UIImage(named: "\(i).png")!
            arrayOfImages.addObject(image)
        }
        arrayOfImages.addObject(blueSquare);
        
        psAnimation.imageViews = arrayOfImages
        psAnimation.transitIndex = 0
        
        psAnimation.animateTheViews(container, withDuration: 1, andWithTransitionOption: UIViewAnimationOptions.TransitionNone , withCompletion: { (viewIndex) -> Void in // viewIndex is index of visible view
            if viewIndex == 0
            {
                designer.startPatternViewAnimation()
            }
        })
        
        animatedBGView!.bgColor = UIColor.whiteColor()
        animatedBGView?.patternImage = UIImage(named: "pattern2.png")
        animatedBGView!.startPatternViewAnimation()
        
    }
    
    @IBAction func next() {
        self.psAnimation.goToNextView()
    }
    
    @IBAction func previous() {
        self.psAnimation.goToPreviousView()
    }
    
    
    @IBAction func rotateTheView(sender: UIButton) {
        
        if sender.tag == 1001
        {
            PSBasicAnimation.rotateTheViewWithFlex(self.container, withDuration:0.7, andWithDegrees: CGFloat(sliderForAngle.value))
        }
        else if sender.tag == 1002
        {
            PSBasicAnimation.rotateTheView(self.container, withDuration:0.7, andWithDegrees: CGFloat(sliderForAngle.value))
        }
    }
    
    // Note:- it will delete or nil the view.
    
    @IBAction func deleteTheImage(sender: UIButton) {
        if (imgPerson != nil){
            PSBasicAnimation.animateTheViewLikeDelete(imgPerson, withComplettion: { (complete) -> Void in
            })
        }
    }
    
    
    @IBAction func shakeTheView(sender: UIButton) {
        PSBasicAnimation.shakeTheView(container, withDuration: 0.07, andWithRepeat: 4)
    }
    
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        lblAngle.text = Int(sender.value).description
    }
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
        let value:Int = Int(sender.value)
        
        switch value {
        case 0:
            psAnimation.transitionOption = UIViewAnimationOptions.TransitionNone
            lblTransitions.text = "TransitionNone"
        case 1:
            psAnimation.transitionOption = UIViewAnimationOptions.TransitionFlipFromLeft
            lblTransitions.text = "TransitionFlipFrom"
        case 2:
            psAnimation.transitionOption = UIViewAnimationOptions.TransitionCurlUp
            lblTransitions.text = "TransitionCurl"
        case 3:
            psAnimation.transitionOption = UIViewAnimationOptions.TransitionCrossDissolve
            lblTransitions.text = "TransitionCrossDissolve"
        case 4:
            psAnimation.transitionOption = UIViewAnimationOptions.TransitionFlipFromTop
            lblTransitions.text = "TransitionFlip"
            
        default:
            psAnimation.transitionOption = UIViewAnimationOptions.TransitionNone
            lblTransitions.text = "TransitionNone"
        }
    }
    
}