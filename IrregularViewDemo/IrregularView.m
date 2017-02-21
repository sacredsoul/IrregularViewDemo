//
//  IrregularView.m
//  IrregularViewDemo
//
//  Created by drefore on 2017/2/21.
//  Copyright © 2017年 LSD. All rights reserved.
//

#import "IrregularView.h"

@interface IrregularView ()
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@end

@implementation IrregularView

- (instancetype)initWithPoints:(NSArray *)points strokeColor:(CGColorRef)strokeColor mode:(IrregularViewMode)mode {
    CGPathRef path = CGPathCreateMutable();
    switch (mode) {
        case IrregularViewModeHexagram:
            path = [IrregularView pathForHexagramFromPoints:points];
            break;
            
        default:
            path = [IrregularView pathFromPoints:points];
            break;
    }
    
    self = [super initWithFrame:CGPathGetPathBoundingBox(path)];
    
    if (self) {
        _shapeLayer = [self setupLayerFromPath:path];
        _shapeLayer.fillColor = [UIColor redColor].CGColor;
        _shapeLayer.strokeColor = strokeColor;
        [self.layer addSublayer:_shapeLayer];
    }
    return self;
}

+ (CGPathRef)pathFromPoints:(NSArray *)points {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:[[points firstObject] CGPointValue]];
    for (NSInteger i = 1; i < points.count; i++) {
        [path addLineToPoint:[[points objectAtIndex:i] CGPointValue]];
    }
    [path closePath];
    
    return path.CGPath;
}

+ (CGPathRef)pathForHexagramFromPoints:(NSArray *)points {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:[[points firstObject] CGPointValue]];
    for (NSInteger i = 2; i < points.count; i+=2) {
        [path addLineToPoint:[[points objectAtIndex:i] CGPointValue]];
    }
    [path closePath];
    
    [path moveToPoint:[[points objectAtIndex:1] CGPointValue]];
    for (NSInteger i = 3; i < points.count; i+=2) {
        [path addLineToPoint:[[points objectAtIndex:i] CGPointValue]];
    }
    [path closePath];
    
    return path.CGPath;
}

- (CAShapeLayer *)setupLayerFromPath:(CGPathRef)path {
    CAShapeLayer *layer = [CAShapeLayer layer];
    CGAffineTransform t = CGAffineTransformMakeTranslation(-CGRectGetMinX(self.frame), -CGRectGetMinY(self.frame));
    layer.path = CGPathCreateCopyByTransformingPath(path, &t);
    layer.fillRule = kCAFillRuleEvenOdd;
    layer.lineWidth = 2.0;
    
    return layer;
}



-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (CGPathContainsPoint(_shapeLayer.path, NULL, point, NO)) {
        return [super hitTest:point withEvent:event];
    } else {
        return nil;
    }
}

@end
