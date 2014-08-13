//
//  HypnosisView.swift
//  Hypnosister
//
//  Created by Omer Wazir on 8/6/14.
//  Copyright (c) 2014 Omer Wazir. All rights reserved.
//

import UIKit

class HypnosisView: UIView {
    
    /*** 
    ***  The required init(coder: NSCoder){} is added to work around the message below:
    **   “Class HypnosisView does not implement its superclass's required members”
    **   stackoverflow.com/questions/25126295/swift-class-does-not-implement-its-superclasss-required-members
    ***/
    
    var circleColor:UIColor {
        
        //does didSet get called in the init since it's the first time it's being set?
        //or do I need to set the value in the declaration for it not to fire the first time?
        didSet {
            self.setNeedsDisplay();
        }
    };
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override init(frame: CGRect) {
        self.circleColor = UIColor.lightGrayColor();
        super.init(frame:frame);
        self.backgroundColor = UIColor.clearColor();
        
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        print("\(self) was touched");
        let red = CGFloat(arc4random() % 100) / 100.0;
        let blue = CGFloat(arc4random() % 100) / 100.0;
        let green = CGFloat(arc4random() % 100) / 100.0;
        let randomColor:UIColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0);
        
        self.circleColor = randomColor;
    }
    
    override func drawRect(rect: CGRect)
    {
        let bounds:CGRect = self.bounds;
        
        let center:CGPoint = CGPoint(x: bounds.origin.x + bounds.size.width / 2.0,
            y: bounds.origin.y + bounds.size.height / 2.0);
        
        //The largest circle will circumscribe the view
        let maxRadius = hypot(bounds.size.height, bounds.size.width) / 2.0;
        let path:UIBezierPath = UIBezierPath();
        
        //Swift can't convert type Float to CGFloat...yet
        //So doing this kinda wonky workaround of creating startAngle and endAngle constants.
        let startAngle = CGFloat(0.0);
        let endAngle = CGFloat(M_PI * 2.0);
        
        for(var currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20){
            path.moveToPoint(CGPointMake(center.x + currentRadius, center.y));
            
            path.addArcWithCenter(center, radius: currentRadius,
                startAngle: startAngle, endAngle: endAngle, clockwise: true);
        }
        
        path.lineWidth = 10.0;
        self.circleColor.setStroke();
        path.stroke();
        
    }

}
