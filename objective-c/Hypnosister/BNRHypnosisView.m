//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by Omer Wazir on 8/3/14.
//  Copyright (c) 2014 Omer Wazir. All rights reserved.
//

#import "BNRHypnosisView.h"

@implementation BNRHypnosisView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    
    //figure out the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    //set the radius to the smaller of the two dimenions allowing portrait/landscape views to be correct
    float radius = MIN(bounds.size.width, bounds.size.height) / 2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    //Add an arc to the path at the center,with radius of radius,
    //from 0 to 2*PI in radians (which makes a cirle)
    [path addArcWithCenter:center
                    radius:radius
                startAngle:0
                  endAngle:M_PI * 2
                 clockwise:YES];
    
    //Now draw the line
    [path stroke];
}


@end
