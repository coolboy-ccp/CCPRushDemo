//
//  ViewController.m
//  CCPRushDemo
//
//  Created by liqunfei on 16/3/7.
//  Copyright © 2016年 chuchengpeng. All rights reserved.
//

#import "ViewController.h"
#import "DrawPath.h"

@interface ViewController ()
{
    CGPoint orginCenter1;
    CGPoint orginCerter2;
}
@property (weak, nonatomic) IBOutlet UIView *rectView;
@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (nonatomic,strong)     UIDynamicAnimator *animator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DrawPath *path = [[DrawPath alloc] initWithFrame:self.view.bounds];
    path.backgroundColor = [UIColor clearColor];
    [self.view addSubview:path];
    [self.view sendSubviewToBack:path];
    self.circleView.layer.cornerRadius = 20.0f;
}

- (UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}
- (void)viewDidAppear:(BOOL)animated {
    orginCenter1 = self.rectView.center;
    orginCerter2 = self.circleView.center;
}

- (void)GravityActionWithDirection:(CGVector)vector {
    UIGravityBehavior *gBehanvior = [[UIGravityBehavior alloc] init];
    gBehanvior.magnitude = 9.87f;
    gBehanvior.gravityDirection = vector;
    [gBehanvior addItem:self.circleView];
    [gBehanvior addItem:self.rectView];
    [self.animator addBehavior:gBehanvior];
    NSArray *arr = @[self.rectView,self.circleView];
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:arr];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
}

- (void)GravityActionCirclr {
    UIGravityBehavior *gBehanvior = [[UIGravityBehavior alloc] init];
    gBehanvior.magnitude = 9.87f;
    gBehanvior.gravityDirection = CGVectorMake(0, 1);
    [gBehanvior addItem:self.circleView];
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
    [collision addItem:self.circleView];
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:60.0f startAngle:0 endAngle:2*M_PI clockwise:YES];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.view.bounds.size.width, 0)];
    [path addLineToPoint:self.view.center];
    [path addLineToPoint:CGPointMake(self.view.center.x, self.view.bounds.size.height)];
    [path addLineToPoint:CGPointMake(0, self.view.bounds.size.height)];
    [path addLineToPoint:CGPointMake(0, 0)];
    [path setLineWidth:2.0];
    [collision addBoundaryWithIdentifier:@"line" forPath:path];
    [self.animator addBehavior:gBehanvior];
    [self.animator addBehavior:collision];
}

- (IBAction)buttonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    int i = -1;
    if (sender.selected) {
        i = 1;
    }
    switch (sender.tag-101) {
        case 0:
            [self.animator removeAllBehaviors];
            [self GravityActionWithDirection:CGVectorMake(0, i)];
            break;
        case 1:
            [self.animator removeAllBehaviors];
            [self GravityActionWithDirection:CGVectorMake(i,0)];
            break;
        case 2:
            [self.animator removeAllBehaviors];
            self.rectView.center = orginCenter1;
            self.circleView.center = orginCerter2;
            break;
        case 3:
            [self.animator removeAllBehaviors];
            [self GravityActionCirclr];
            break;
        default:
            break;
    }
}



@end
