//
//  ViewController.m
//  IrregularViewDemo
//
//  Created by drefore on 2017/2/21.
//  Copyright © 2017年 LSD. All rights reserved.
//

#import "ViewController.h"
#import "IrregularView.h"

@interface ViewController ()
@property (nonatomic, assign) CGPoint originalPoint;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGPoint center = CGPointMake(self.view.bounds.size.width/4.0, self.view.center.y);
    CGFloat radius = self.view.bounds.size.width/8.0;
    [self setupHexagonViewWithCenter:center radius:radius strokeColor:[UIColor orangeColor].CGColor];
    [self setupHexagramViewWithCenter:center radius:radius strokeColor:[UIColor orangeColor].CGColor];
}

- (IrregularView *)setupHexagonViewWithCenter:(CGPoint)center radius:(CGFloat)radius strokeColor:(CGColorRef)strokeColor {
    NSMutableArray *points = [self calculateHexagonWithCenter:center radius:radius];
    [points exchangeObjectAtIndex:1 withObjectAtIndex:4];
    [points exchangeObjectAtIndex:2 withObjectAtIndex:4];
    [points exchangeObjectAtIndex:4 withObjectAtIndex:5];
    IrregularView *irregularView = [[IrregularView alloc] initWithPoints:points strokeColor:strokeColor mode:IrregularViewModeDefault];
    [self.view addSubview:irregularView];
    [self addPanGestureToView:irregularView];
    
    return irregularView;
}

- (IrregularView *)setupHexagramViewWithCenter:(CGPoint)center radius:(CGFloat)radius strokeColor:(CGColorRef)strokeColor {
    NSMutableArray *points = [self calculateHexagonWithCenter:center radius:radius];
    IrregularView *irregularView = [[IrregularView alloc] initWithPoints:points strokeColor:strokeColor mode:IrregularViewModeHexagram];
    [self.view addSubview:irregularView];
    [self addPanGestureToView:irregularView];
    
    return irregularView;
}

- (NSMutableArray *)calculateHexagonWithCenter:(CGPoint)center radius:(CGFloat)radius {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        CGPoint point = CGPointMake(center.x+sin(i*M_PI/3.0)*radius, center.y-cos(i*M_PI/3.0)*radius);
        [array addObject:[NSValue valueWithCGPoint:point]];
    }
    return array;
}

- (void)addPanGestureToView:(UIView *)view {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [view addGestureRecognizer:panGesture];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        _originalPoint = panGesture.view.center;
    }
    
    if (panGesture.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [panGesture translationInView:self.view];
        panGesture.view.center = CGPointMake(_originalPoint.x+point.x, _originalPoint.y+point.y);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
