//
//  DrawPath.m
//  CCPRushDemo
//
//  Created by liqunfei on 16/3/7.
//  Copyright © 2016年 chuchengpeng. All rights reserved.
//

#import "DrawPath.h"

@implementation DrawPath

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.bounds.size.width, 0)];
    [path addLineToPoint:self.center];
    [path addLineToPoint:CGPointMake(self.center.x, self.bounds.size.height)];
    [path addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    [path addLineToPoint:CGPointMake(0, 0)];
    [path setLineWidth:2.0];
    [[UIColor redColor] setStroke];
    [path stroke];
}

@end
