//
//  ScrollWheel.m
//  ScrollWheel
//
//  Created by Adusa on 15/9/2.
//  Copyright (c) 2015年 Adusa. All rights reserved.
//

#import "ScrollWheel.h"

CGPoint centeredPoint(CGPoint pt,CGPoint origin)
{
    return CGPointMake(pt.x-origin.x, pt.y-origin.y);
}

float getangle(CGPoint p1,CGPoint c1)
{
    CGPoint p=centeredPoint(p1, c1);
    float h=ABS(sqrt(p.x*p.x+p.y*p.y));
    float a=p.x;
    float baseAngle=acos(a/h)*180.0f/M_PI;
    if (p1.y>c1.y) {
        baseAngle=360.0f-baseAngle;
    }
    return baseAngle;
}

BOOL pointInsideRadius(CGPoint p1,float r,CGPoint c1)
{
    CGPoint pt=centeredPoint(p1, c1);
    float xsquared=pt.x*pt.x;
    float ysquared=pt.y*pt.y;
    float h=ABS(sqrt(xsquared+ysquared));
    if (((xsquared+ysquared)/h)<r) {
        return YES;
    }
    return NO;
}

@implementation ScrollWheel

-(instancetype)initWithFrame:(CGRect)aframe
{
    self=[super initWithFrame:aframe];
    if (self) {
        CGRect f=aframe;
        f.size=self.intrinsicContentSize;
        self.frame=f;
        UIImageView *iv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"5.png"]];
        [self addSubview:iv];
    }
    return self;
}

-(CGSize)intrinsicContentSize
{
    return CGSizeMake(128, 128);
}

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint p=[touch locationInView:self];
    CGPoint cp=CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    if (!pointInsideRadius(p, cp.x, cp)) {
        return NO;
    }
    if (pointInsideRadius(p,20.0f, cp)) {
        return NO;
    }
    self.theta=getangle(p, cp);
    [self sendActionsForControlEvents:UIControlEventTouchDown];
    return YES;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint p=[touch locationInView:self];
    CGPoint cp=CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    if (CGRectContainsPoint(self.frame, p)) {
        [self sendActionsForControlEvents:UIControlEventTouchDragInside];
    }else
    {
        [self sendActionsForControlEvents:UIControlEventTouchDragOutside];
    }
    if (!pointInsideRadius(p, cp.x+50.0f, cp)) {
        return NO;
    }
    float newtheta=getangle([touch locationInView:self], cp);
    float dtheta=newtheta-self.theta;
    int ntimes=0;
    while ((ABS(dtheta)>300.0f)&&(ntimes++<4)) {
        if (dtheta>0.0f) {
            dtheta-=360.0f;
        }
        else{
            dtheta+=360.0f;
        }
    }
    self.value-=dtheta/360.0f;
    self.theta=newtheta;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPoint=[touch locationInView:self];
    if (CGRectContainsPoint(self.bounds, touchPoint)) {
        [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
else
{
    [self sendActionsForControlEvents:UIControlEventTouchUpOutside];
}
}

-(void)cancelTrackingWithEvent:(UIEvent *)event
{
    [self sendActionsForControlEvents:UIControlEventTouchCancel];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
