//
//  SJZoomView.swift
//  SJZoomView
//
//  Created by Saurabh Jain on 5/3/15.
//  Copyright (c) 2015 Saurabh Jain. All rights reserved.
//

import UIKit

class SJZoomView: UIView {
    
    var zoomScale: CGFloat = 2.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var draggable: Bool = true {
        didSet{
            userInteractionEnabled = !userInteractionEnabled
        }
    }
    
    var inverted: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    // Pan Gesture
    private var panGestureRecognizer: UIPanGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp()
    {
        backgroundColor = UIColor.clearColor()
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        addGestureRecognizer(panGestureRecognizer)
    }
    
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        CGContextTranslateCTM(context, frame.size.width/2, frame.size.height/2)
        CGContextScaleCTM(context, zoomScale, zoomScale)
        if inverted {
            CGContextRotateCTM(context, degreesToRadians(180))
        }
        CGContextTranslateCTM(context, -(self.frame.origin.x) - (self.frame.size.width / 2), -(self.frame.origin.y) - (self.frame.size.height / 2));
        
        hidden = true
        self.superview?.layer.superlayer.renderInContext(context)
        hidden = false
    }
    
    private func degreesToRadians(angle: CGFloat) -> CGFloat
    {
        let ans = CGFloat(angle * CGFloat(M_PI/180.0))
        return ans
    }

}


extension SJZoomView {
    
    func handlePan(recognizer: UIPanGestureRecognizer)
    {
        let translation = recognizer.translationInView(self)
        center = CGPointMake(center.x + translation.x, center.y + translation.y)
        recognizer.setTranslation(CGPointZero, inView: self)
        setNeedsDisplay()
    }
    
}
