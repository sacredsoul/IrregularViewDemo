//
//  IrregularView.h
//  IrregularViewDemo
//
//  Created by drefore on 2017/2/21.
//  Copyright © 2017年 LSD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, IrregularViewMode) {
    IrregularViewModeDefault,
    IrregularViewModeHexagram
};

@interface IrregularView : UIView
- (instancetype)initWithPoints:(NSArray *)points strokeColor:(CGColorRef)strokeColor mode:(IrregularViewMode)mode;

@end
