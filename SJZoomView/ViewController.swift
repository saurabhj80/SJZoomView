//
//  ViewController.swift
//  SJZoomView
//
//  Created by Saurabh Jain on 5/3/15.
//  Copyright (c) 2015 Saurabh Jain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var sj_zoomView : SJZoomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var frame = CGRectMake(50, 50, CGRectGetWidth(view.bounds) - 100, CGRectGetHeight(view.bounds) - 100)
        
        sj_zoomView = SJZoomView(frame: frame)
        sj_zoomView.layer.borderColor = UIColor.blackColor().CGColor
        sj_zoomView.layer.borderWidth = 3
        //sj_zoomView.inverted = true
        
        view.addSubview(sj_zoomView)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotate:", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }

    func rotate(note: NSNotification) {
        sj_zoomView.setNeedsDisplay()
    }

}

