//
//  ViewController.swift
//  KDCircularProgressExample
//
//  Created by Kaan Dedeoglu on 2/12/15.
//  Copyright (c) 2015 Kaan Dedeoglu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var progress: KDCircularProgress!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.22, alpha: 1)
        
        progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        progress.startAngle = -90
        progress.progressThickness = 0.2
        progress.trackThickness = 0.6
        progress.clockwise = true
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = false
        progress.glowMode = .forward
        progress.glowAmount = 0.9
        progress.setColors(colors: UIColor.cyan ,UIColor.white, UIColor.magenta, UIColor.white, UIColor.orange)
        progress.center = CGPoint(x: view.center.x, y: view.center.y + 25)
        view.addSubview(progress)
    }
    
    @IBAction func sliderDidChangeValue(_ sender: UISlider) {
        progress.angle = Double(sender.value)
    }
    
    @IBAction func animateButtonTapped(_ sender: UIButton) {
        progress.animate(fromAngle: 0, toAngle: 360, duration: 5) { completed in
            if completed {
                print("animation stopped, completed")
            } else {
                print("animation stopped, was interrupted")
            }
        }
    }
}





/*
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 @IBDesignable
 public class KDCircularProgress: UIView {
 
 
 
 
 
 
 
 
 
 
 
 
 
 // MARK: - Thumb view
 
 // MARK: - thumb ui elements
 
 private var thumbView: UIView! {
 didSet {
 thumbView.backgroundColor = .redColor()
 }
 }
 
 public var thumbDigitLabel = UILabel()
 private var thumbPercentLabel = UILabel()
 
 // MARK: - Thumb var and let
 
 private var thumbParameters = KDCircularProgressThumbViewParameters()
 private var thumbDigitLabelFrame = CGRectZero
 private var thumbPercentLabelFrame = CGRectZero
 private var thumbViewIsAdded = false
 
 // MARK: - thumb functions
 
 
 // MARK: - position thumb view
 public func showThumbView(thumbParameter: KDCircularProgressThumbViewParameters) {
 if (thumbViewIsAdded == false) {
 thumbViewIsAdded = true
 //            let thumbParameter = KDCircularProgressThumbViewParameters()
 //            thumbParameter.showThumbView = true
 //            thumbParameter.thumViewBackgroundColor = .greenColor()
 //            thumbParameter.size = CGSizeMake(40, 40)
 //            thumbParameter.borderColor = .whiteColor()
 //            thumbParameter.borderWidth = 2
 //            thumbParameter.digitLabelTextColor = .blackColor()
 //            thumbParameter.percentLabelTextColor = .blackColor()
 addThumbView(thumbParameter)
 }
 }
 
 public func setThumbViewPositions(degrees: Double) {
 if thumbViewIsAdded == true {
 thumbView.center = thumbCenter(degrees)
 }
 }
 
 private func addThumbView(parameters: KDCircularProgressThumbViewParameters) {
 thumbView = UIView()
 thumbView.frame.size = parameters.size
 thumbView.center = thumbCenter(130)
 thumbView.backgroundColor = parameters.thumViewBackgroundColor
 thumbView.layer.cornerRadius = thumbView.frame.size.height / 2
 addSubview(thumbView)
 
 // border
 thumbView.layer.borderColor = parameters.borderColor.CGColor
 thumbView.layer.borderWidth = parameters.borderWidth
 
 // shadow
 let shadowRect = CGRectInset(thumbView.bounds, 0, 2)
 let shadowPath = UIBezierPath(roundedRect: shadowRect, cornerRadius: parameters.size.height / 2).CGPath
 
 thumbView.layer.shadowPath = shadowPath
 thumbView.layer.shadowColor = UIColor.blackColor().CGColor
 thumbView.layer.shadowOpacity = 0.25
 thumbView.layer.shadowOffset = CGSizeMake(0, 2)
 
 
 // label
 thumbDigitLabel.frame = CGRect(x: 0, y: thumbView.bounds.height / 2 - 9, width: thumbView.bounds.width, height: 17)
 thumbDigitLabel.text = "88"
 thumbDigitLabel.font = parameters.digitLabelFont
 thumbDigitLabel.textColor = parameters.digitLabelTextColor
 thumbDigitLabel.textAlignment = .Center
 thumbView.addSubview(thumbDigitLabel)
 
 // set standard frame
 thumbDigitLabelFrame = thumbDigitLabel.frame
 
 // percent label
 //        thumbPercentLabel = UILabel(frame: CGRect(x: 8 + 18, y: thumbView.bounds.height / 2 - 8.5 + 5, width: 8, height: 11))
 //        thumbPercentLabel.text = "%"
 //        thumbPercentLabel.font = parameters.percentLabelFont
 //        thumbPercentLabel.textColor = parameters.percentLabelTextColor
 //        thumbPercentLabel.textAlignment = .Left
 //        thumbView.addSubview(thumbPercentLabel)
 
 // set standard frame
 thumbPercentLabelFrame = thumbPercentLabel.frame
 
 }
 
 private func thumbCenter(degree: Double) -> CGPoint {
 return Math.pointFromAngle(bounds, angle: degree, radius: Double(self.radius * 0.9))
 }
 
 private func moveThumbView() {
 let degree = Math.pointFromAngle(bounds, angle: angle + 130, radius: Double(radius) * 0.9)
 thumbView.center = degree
 
 // function for digit label
 configureDigitLabelFontSize()
 }
 
 public func moveThumbView(angle: Double) {
 let rect = CGRect(x: 0, y: 0, width: 170, height: 170)
 let degree = Math.pointFromAngle(rect, angle: angle + 130, radius: Double(rect.height / 2) * 0.9)
 thumbView.center = degree
 
 // function for digit label
 configureDigitLabelFontSize()
 }
 
 // original
 //    public func moveThumbView(angle: Double) {
 //        let degree = Math.pointFromAngle(bounds, angle: angle + 130, radius: Double(radius) * 0.9)
 //        thumbView.center = degree
 //
 //        // function for digit label
 //        configureDigitLabelFontSize()
 //    }
 
 // MARK: - ui functions
 
 private func configureDigitLabelFontSize() {
 //        if thumbDigitLabel.text == "100" {
 //            let onePercent = thumbDigitLabel.frame.size.height / 100
 //            let newPercents = CGFloat(Double(round(Double(thumbDigitLabel.intrinsicContentSize().width / onePercent) * 100) / 100) - 100)
 //            print(newPercents)
 //
 //            // new parameters
 //            let newDigitLabelX = thumbDigitLabelFrame.origin.x  - thumbDigitLabelFrame.origin.x / 100 * newPercents
 //            let newDigitLabelFrame = CGRect(x: newDigitLabelX, y: thumbDigitLabelFrame.origin.y, width: thumbDigitLabel.intrinsicContentSize().width, height: thumbDigitLabel.intrinsicContentSize().height)
 //
 //            //
 //            let newPercentLabelX = newDigitLabelX + thumbDigitLabel.intrinsicContentSize().width
 //            let newPercentLabelFrame = CGRect(x: newPercentLabelX, y: thumbPercentLabelFrame.origin.y, width: thumbPercentLabelFrame.width, height: thumbPercentLabelFrame.height)
 //
 //            UIView.animateWithDuration(0.1, animations: {
 //                self.thumbDigitLabel.frame = newDigitLabelFrame
 //                self.thumbPercentLabel.frame = newPercentLabelFrame
 //            })
 //        } else {
 //            UIView.animateWithDuration(0.1, animations: {
 //                self.thumbDigitLabel.frame = self.thumbDigitLabelFrame
 //                self.thumbPercentLabel.frame = self.thumbPercentLabelFrame
 //            })
 //        }
 }
 
 
 // MARK: - sizing
 
 
 
 
 
 //These are used only from the Interface-Builder. Changing these from code will have no effect.
 //Also IB colors are limited to 3, whereas programatically we can have an arbitrary number of them.
 
 
 
 
 
 override public init(frame: CGRect) {
 super.init(frame: frame)
 userInteractionEnabled = false
 setInitialValues()
 refreshValues()
 checkAndSetIBColors()
 
 // thumb
 //        addThumbView()
 }
 
 convenience public init(frame: CGRect, thumbParameters: KDCircularProgressThumbViewParameters) {
 self.init(frame: frame)
 userInteractionEnabled = false
 setInitialValues()
 refreshValues()
 checkAndSetIBColors()
 
 self.thumbParameters = thumbParameters
 
 // thumb
 if thumbParameters.showThumbView == true {
 addThumbView(thumbParameters)
 }
 }
 
 convenience public init(frame:CGRect, colors: UIColor...) {
 self.init(frame: frame)
 setColors(colors)
 }
 
 required public init(coder aDecoder: NSCoder) {
 super.init(coder: aDecoder)!
 translatesAutoresizingMaskIntoConstraints = false
 userInteractionEnabled = false
 setInitialValues()
 refreshValues()
 
 // thumb
 //        addThumbView()
 }
 
 public override func awakeFromNib() {
 checkAndSetIBColors()
 }
 
 override public class func layerClass() -> AnyClass {
 return KDCircularProgressViewLayer.self
 }
 
 
 public override func layoutSubviews() {
 super.layoutSubviews()
 radius = (frame.size.width/2.0) //* 0.8
 }
 
 private func setInitialValues() {
 radius = (frame.size.width/2.0) //* 0.8 //We always apply a 20% padding, stopping glows from being clipped
 backgroundColor = .clearColor()
 setColors(UIColor.whiteColor(), UIColor.redColor())
 }
 
 private func refreshValues() {
 progressLayer.angle = angle
 progressLayer.startAngle = UtilityFunctions.Mod(startAngle, range: 360, minMax: (0,360))
 progressLayer.clockwise = clockwise
 progressLayer.roundedCorners = roundedCorners
 progressLayer.lerpColorMode = lerpColorMode
 progressLayer.gradientRotateSpeed = gradientRotateSpeed
 progressLayer.glowAmount = UtilityFunctions.Clamp(glowAmount, minMax: (0, 1))
 progressLayer.glowMode = glowMode
 progressLayer.progressThickness = progressThickness/2
 progressLayer.trackColor = trackColor
 progressLayer.trackThickness = trackThickness/2
 }
 
 private func checkAndSetIBColors() {
 let nonNilColors = [IBColor1, IBColor2, IBColor3].filter { $0 != nil}.map { $0! }
 if nonNilColors.count > 0 {
 setColors(nonNilColors)
 }
 }
 
 public func setColors(colors: UIColor...) {
 setColors(colors)
 }
 
 private func setColors(colors: [UIColor]) {
 progressLayer.colorsArray = colors
 progressLayer.setNeedsDisplay()
 }
 
 public func animateFromAngle(fromAngle: Double, toAngle: Double, duration: NSTimeInterval, relativeDuration: Bool = true, completion: ((Bool) -> Void)?) {
 if isAnimating() {
 pauseAnimation()
 }
 
 let animationDuration: NSTimeInterval
 if relativeDuration {
 animationDuration = duration
 } else {
 let traveledAngle = UtilityFunctions.Mod(toAngle - fromAngle, range: 360, minMax: (0, 360))
 let scaledDuration = (NSTimeInterval(traveledAngle) * duration) / 360
 animationDuration = scaledDuration
 }
 
 let animation = CABasicAnimation(keyPath: "angle")
 animation.fromValue = fromAngle
 animation.toValue = toAngle
 animation.duration = animationDuration
 animation.delegate = self
 angle = toAngle
 animationCompletionBlock = completion
 
 progressLayer.addAnimation(animation, forKey: "angle")
 }
 
 public func animateToAngle(toAngle: Double, duration: NSTimeInterval, relativeDuration: Bool = true, completion: ((Bool) -> Void)?) {
 if isAnimating() {
 pauseAnimation()
 }
 animateFromAngle(angle, toAngle: toAngle, duration: duration, relativeDuration: relativeDuration, completion: completion)
 }
 
 public func pauseAnimation() {
 guard let presentationLayer = progressLayer.presentationLayer() as? KDCircularProgressViewLayer else { return }
 let currentValue = presentationLayer.angle
 progressLayer.removeAllAnimations()
 animationCompletionBlock = nil
 angle = currentValue
 }
 
 public func stopAnimation() {
 progressLayer.removeAllAnimations()
 angle = 0
 }
 
 public func isAnimating() -> Bool {
 return progressLayer.animationForKey("angle") != nil
 }
 
 override public func animationDidStop(anim: CAAnimation, finished flag: Bool) {
 if let completionBlock = animationCompletionBlock {
 completionBlock(flag)
 animationCompletionBlock = nil
 }
 }
 
 public override func didMoveToWindow() {
 if let window = window {
 progressLayer.contentsScale = window.screen.scale
 }
 }
 
 public override func willMoveToSuperview(newSuperview: UIView?) {
 if newSuperview == nil && isAnimating() {
 pauseAnimation()
 }
 }
 
 public override func prepareForInterfaceBuilder() {
 setInitialValues()
 refreshValues()
 checkAndSetIBColors()
 progressLayer.setNeedsDisplay()
 }
 
 private class KDCircularProgressViewLayer: CALayer {
 @NSManaged var angle: Double
 var radius: CGFloat! {
 didSet {
 invalidateGradientCache()
 }
 }
 var startAngle: Double!
 var clockwise: Bool! {
 didSet {
 if clockwise != oldValue {
 invalidateGradientCache()
 }
 }
 }
 var roundedCorners: Bool!
 var lerpColorMode: Bool!
 var gradientRotateSpeed: CGFloat! {
 didSet {
 invalidateGradientCache()
 }
 }
 var glowAmount: CGFloat!
 var glowMode: KDCircularProgressGlowMode!
 var progressThickness: CGFloat!
 var trackThickness: CGFloat!
 var trackColor: UIColor!
 var progressInsideFillColor: UIColor = UIColor.clearColor()
 var colorsArray: [UIColor]! {
 didSet {
 invalidateGradientCache()
 }
 }
 private var gradientCache: CGGradientRef?
 private var locationsCache: [CGFloat]?
 
 private struct GlowConstants {
 private static let sizeToGlowRatio: CGFloat = 0.00015
 static func glowAmountForAngle(angle: Double, glowAmount: CGFloat, glowMode: KDCircularProgressGlowMode, size: CGFloat) -> CGFloat {
 switch glowMode {
 case .Forward:
 return CGFloat(angle) * size * sizeToGlowRatio * glowAmount
 case .Reverse:
 return CGFloat(360 - angle) * size * sizeToGlowRatio * glowAmount
 case .Constant:
 return 360 * size * sizeToGlowRatio * glowAmount
 default:
 return 0
 }
 }
 }
 
 override class func needsDisplayForKey(key: String) -> Bool {
 return key == "angle" ? true : super.needsDisplayForKey(key)
 }
 
 override init(layer: AnyObject) {
 super.init(layer: layer)
 let progressLayer = layer as! KDCircularProgressViewLayer
 radius = progressLayer.radius
 angle = progressLayer.angle
 startAngle = progressLayer.startAngle
 clockwise = progressLayer.clockwise
 roundedCorners = progressLayer.roundedCorners
 lerpColorMode = progressLayer.lerpColorMode
 gradientRotateSpeed = progressLayer.gradientRotateSpeed
 glowAmount = progressLayer.glowAmount
 glowMode = progressLayer.glowMode
 progressThickness = progressLayer.progressThickness
 trackThickness = progressLayer.trackThickness
 trackColor = progressLayer.trackColor
 colorsArray = progressLayer.colorsArray
 progressInsideFillColor = progressLayer.progressInsideFillColor
 }
 
 override init() {
 super.init()
 }
 
 required init?(coder aDecoder: NSCoder) {
 super.init(coder: aDecoder)
 }
 
 override func drawInContext(ctx: CGContext) {
 UIGraphicsPushContext(ctx)
 let rect = bounds
 let size = rect.size
 
 let trackLineWidth: CGFloat = radius * trackThickness
 let progressLineWidth = radius * progressThickness
 let arcRadius = max(radius - trackLineWidth/2, radius - progressLineWidth/2)
 CGContextAddArc(ctx, CGFloat(size.width/2.0), CGFloat(size.height/2.0), arcRadius, 0, CGFloat(M_PI * 2), 0)
 trackColor.set()
 CGContextSetStrokeColorWithColor(ctx, trackColor.CGColor)
 CGContextSetFillColorWithColor(ctx, progressInsideFillColor.CGColor)
 CGContextSetLineWidth(ctx, trackLineWidth)
 CGContextSetLineCap(ctx, CGLineCap.Butt)
 CGContextDrawPath(ctx, .FillStroke)
 
 UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
 let imageCtx = UIGraphicsGetCurrentContext()
 let reducedAngle = UtilityFunctions.Mod(angle, range: 360, minMax: (0, 360))
 let fromAngle = ConversionFunctions.DegreesToRadians(CGFloat(-startAngle))
 let toAngle = ConversionFunctions.DegreesToRadians(CGFloat((clockwise == true ? -reducedAngle : reducedAngle) - startAngle))
 CGContextAddArc(imageCtx, CGFloat(size.width/2.0),CGFloat(size.height/2.0), arcRadius, fromAngle, toAngle, clockwise == true ? 1 : 0)
 let glowValue = GlowConstants.glowAmountForAngle(reducedAngle, glowAmount: glowAmount, glowMode: glowMode, size: size.width)
 if glowValue > 0 {
 CGContextSetShadowWithColor(imageCtx, CGSizeZero, glowValue, UIColor.blackColor().CGColor)
 }
 CGContextSetLineCap(imageCtx, roundedCorners == true ? .Round : .Butt)
 CGContextSetLineWidth(imageCtx, progressLineWidth)
 CGContextDrawPath(imageCtx, .Stroke)
 
 let drawMask: CGImageRef = CGBitmapContextCreateImage(UIGraphicsGetCurrentContext())!
 UIGraphicsEndImageContext()
 
 CGContextSaveGState(ctx)
 CGContextClipToMask(ctx, bounds, drawMask)
 
 //Gradient - Fill
 if !lerpColorMode && colorsArray.count > 1 {
 var componentsArray: [CGFloat] = []
 let rgbColorsArray: [UIColor] = colorsArray.map {c in // Make sure every color in colors array is in RGB color space
 if CGColorGetNumberOfComponents(c.CGColor) == 2 {
 let whiteValue = CGColorGetComponents(c.CGColor)[0]
 return UIColor(red: whiteValue, green: whiteValue, blue: whiteValue, alpha: 1.0)
 } else {
 return c
 }
 }
 
 for color in rgbColorsArray {
 let colorComponents: UnsafePointer<CGFloat> = CGColorGetComponents(color.CGColor)
 componentsArray.appendContentsOf([colorComponents[0],colorComponents[1],colorComponents[2],1.0])
 }
 
 drawGradientWithContext(ctx, componentsArray: componentsArray)
 } else {
 
 var color: UIColor! = nil
 if colorsArray.count == 0 {
 color = UIColor.whiteColor()
 } else if colorsArray.count == 1 {
 color = colorsArray[0]
 } else {
 
 // lerpColorMode is true
 
 let t = CGFloat(reducedAngle) / 360
 let steps = colorsArray.count - 1;
 let step = 1 / CGFloat(steps);
 for i in 1...steps {
 let fi = CGFloat(i)
 if (t <= fi * step || i == steps) {
 let colorT = UtilityFunctions.InverseLerp(t, minMax: ((fi - 1) * step, fi * step))
 color = UtilityFunctions.ColorLerp(colorT, minMax: (colorsArray[i - 1], colorsArray[i]));
 break;
 }
 }
 }
 
 fillRectWithContext(ctx, color: color)
 }
 CGContextRestoreGState(ctx)
 UIGraphicsPopContext()
 }
 
 private func fillRectWithContext(ctx: CGContext!, color: UIColor) {
 CGContextSetFillColorWithColor(ctx, color.CGColor)
 CGContextFillRect(ctx, bounds)
 }
 
 private func drawGradientWithContext(ctx: CGContext!, componentsArray: [CGFloat]) {
 let baseSpace = CGColorSpaceCreateDeviceRGB()
 let locations = locationsCache ?? gradientLocationsFromColorCount(componentsArray.count/4, gradientWidth: bounds.size.width)
 let gradient: CGGradient
 
 if let g = self.gradientCache {
 gradient = g
 } else {
 guard let g = CGGradientCreateWithColorComponents(baseSpace, componentsArray, locations,componentsArray.count / 4) else { return }
 self.gradientCache = g
 gradient = g
 }
 
 let halfX = bounds.size.width/2.0
 let floatPi = CGFloat(M_PI)
 let rotateSpeed = clockwise == true ? gradientRotateSpeed : gradientRotateSpeed * -1
 let angleInRadians = ConversionFunctions.DegreesToRadians(rotateSpeed * CGFloat(angle) - 90)
 let oppositeAngle = angleInRadians > floatPi ? angleInRadians - floatPi : angleInRadians + floatPi
 
 let startPoint = CGPoint(x: (cos(angleInRadians) * halfX) + halfX, y: (sin(angleInRadians) * halfX) + halfX)
 let endPoint = CGPoint(x: (cos(oppositeAngle) * halfX) + halfX, y: (sin(oppositeAngle) * halfX) + halfX)
 
 CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, .DrawsBeforeStartLocation)
 }
 
 private func gradientLocationsFromColorCount(colorCount: Int, gradientWidth: CGFloat) -> [CGFloat] {
 if colorCount == 0 || gradientWidth == 0 {
 return []
 } else {
 var locationsArray: [CGFloat] = []
 let progressLineWidth = radius * progressThickness
 let firstPoint = gradientWidth/2 - (radius - progressLineWidth/2)
 let increment = (gradientWidth - (2*firstPoint))/CGFloat(colorCount - 1)
 
 for i in 0..<colorCount {
 locationsArray.append(firstPoint + (CGFloat(i) * increment))
 }
 assert(locationsArray.count == colorCount, "color counts should be equal")
 let result = locationsArray.map { $0 / gradientWidth }
 locationsCache = result
 return result
 }
 }
 
 private func invalidateGradientCache() {
 gradientCache = nil
 locationsCache = nil
 }
 }
 
 private let instanceLayer = CALayer()
 public func showAndAnimateArrow() {
 print("showAndAnimateArrow()")
 let tempAngle: CGFloat = ConversionFunctions.DegreesToRadians(225)
 let myImage = UIImage(named: "GreenLifelineArrow")?.CGImage
 let angle = Float(M_PI * 2.0) / 60
 let layerWidth: CGFloat = 8.0
 let midX = CGRectGetMidX(progressLayer.bounds) - layerWidth / 2.0
 
 let fadeAnimation = CABasicAnimation(keyPath: "opacity")
 fadeAnimation.fromValue = 1.0
 fadeAnimation.toValue = 0.0
 fadeAnimation.duration = 3.5
 
 instanceLayer.frame = CGRect(x: midX, y: 0.0, width: layerWidth, height: layerWidth * 2.0)
 instanceLayer.contents = myImage
 instanceLayer.opacity = 0.0
 instanceLayer.addAnimation(fadeAnimation, forKey: "FadeAnimation")
 
 let replicatorLayer = CAReplicatorLayer()
 replicatorLayer.frame = progressLayer.bounds
 replicatorLayer.instanceCount = Int(progressLayer.angle) / 6
 replicatorLayer.instanceDelay = CFTimeInterval(1 / 15.0)
 replicatorLayer.preservesDepth = false
 replicatorLayer.instanceColor = UIColor.whiteColor().CGColor
 replicatorLayer.transform = CATransform3DMakeRotation(tempAngle,0,0,1)
 replicatorLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(angle), 0, 0, 15.0)
 replicatorLayer.addSublayer(instanceLayer)
 progressLayer.addSublayer(replicatorLayer)
 
 bringSubviewToFront(thumbView)
 
 }
 
 public func removeArrowAnimation() {
 if instanceLayer.animationForKey("FadeAnimation") != nil {
 instanceLayer.removeAnimationForKey("FadeAnimation")
 }
 }
 
 }

 */
