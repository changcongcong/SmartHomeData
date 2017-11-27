//
//  CLine.h
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/8.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLine : UIView

typedef enum{
    UILineStyleVertical,
    UILineStyleHorizon
}UILineStyle;

typedef enum {
    HLineModeSolid,
    HLineModeDash,
}HLineMode;

@property(nonatomic,strong) UIColor *lineColor;
@property(nonatomic,readwrite) CGFloat lineWidth;
@property(nonatomic,readwrite) UILineStyle lineStyle;
@property(nonatomic,readwrite) HLineMode lineMode;

@end
