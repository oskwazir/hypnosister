//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by Omer Wazir on 8/3/14.
//  Copyright (c) 2014 Omer Wazir. All rights reserved.
//

#import "BNRHypnosisView.h"

@interface BNRHypnosisView()

@property (strong,nonatomic) UIColor *circleColor;

@end

@implementation BNRHypnosisView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // All BNRHypnosisViews will start with a clear background color
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    return self;
}

-(void)setCircleColor:(UIColor *)circleColor{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

// when a user touches the screen
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@ was touched", self);
    
    //get 3 random numbers between 1 and 0
    float red = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    
    UIColor *randomColor = [UIColor colorWithRed:red
                                           green:green
                                            blue:blue
                                           alpha:1.0];
    
    self.circleColor = randomColor;
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
    
    //the largest circle will circumscribe the view
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    

    for(float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20){
        
        //Need to move where drawing starts so that the circles aren't joined together
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        
        [path addArcWithCenter:center
                        radius:currentRadius
                    startAngle:0.0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
    }
    
    //Set line width to 10 points
    path.lineWidth = 10;
    
    //Configure the drawing color to light gray
    [self.circleColor  setStroke];
    
    //Now draw the line
    [path stroke];
}


@end
