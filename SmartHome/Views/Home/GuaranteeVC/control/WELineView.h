//
//  WELineView.h
//  waterelephantloan
//
//  Created by waterpant on 2017/9/4.
//  Copyright © 2017年 waterelephant. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LineStyle) {
    LineStyleHorizontal,
    LineStyleVertical
};

@interface WELineView : UIView

@property(assign,nonatomic)LineStyle lineDirection;



@end
