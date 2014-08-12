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
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame);
        self.backgroundColor = UIColor.clearColor();
    }
    
    override func drawRect(rect: CGRect)
    {
        let bounds:CGRect = self.bounds;
        let hypnoToadBounds:CGRect = CGRectMake(bounds.origin.x + bounds.size.width / 4.0,
            bounds.origin.y + bounds.size.height / 4.0, bounds.size.width / 1.58, bounds.size.height / 2.0);
    
        let hypnoToad:UIImage = UIImage(named: "hypnotoad.png");
        
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
        UIColor.lightGrayColor().setStroke();
        path.stroke();
        
        //get the current graphics context
        var currentContext:CGContextRef = UIGraphicsGetCurrentContext();
        
        //save the context before applying a clipping path to it
        CGContextSaveGState(currentContext);
        
        
        //points for the clipping path
        let startPoint:CGPoint = CGPointMake(bounds.origin.x + (bounds.size.width / 2.0), bounds.origin.y + (bounds.size.height * 0.15) );
        let secondPoint:CGPoint = CGPointMake(bounds.origin.x + bounds.size.width - 20, bounds.origin.y + (bounds.size.height * 0.85) );
        let thirdPoint:CGPoint = CGPointMake(bounds.origin.x + 20, bounds.origin.y + (bounds.size.height * 0.85) );
        
        //make a new path, but can I use the existing one?
        let triangle:UIBezierPath = UIBezierPath();
        triangle.moveToPoint(startPoint);
        triangle.addLineToPoint(secondPoint);
        triangle.addLineToPoint(thirdPoint);
        triangle.closePath();
        
        //now apply the clipping path
        triangle.addClip();
        
        //apply the gradient to the inside of the triangle
        let locations:[CGFloat] = [0.0,1.0];
        let components:[CGFloat] = [0.0, 1.0, 0.0, 1.0, 1.0,1.0,0.0,1.0];
        let endPoint:CGPoint = CGPointMake(bounds.origin.x + (bounds.size.width / 2.0), bounds.origin.y + (bounds.size.height * 0.85) );
        
        let colorSpace:CGColorSpaceRef = CGColorSpaceCreateDeviceRGB();
        let gradient:CGGradientRef = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
        
        //swift doesn't like kCGGradientDrawsAfterEndLocation 
        CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
        
        CGContextRestoreGState(currentContext);
        
        
        //save the context before applying a shadow to it
        CGContextSaveGState(currentContext);
        
        //set a shadow to the context
        CGContextSetShadow(currentContext, CGSizeMake(4, 6), 2.5);
        
        hypnoToad.drawInRect(hypnoToadBounds);
        
        //restore the context so new drawings don't have a  shadow on them
        CGContextRestoreGState(currentContext);
    
    }

}
