//
//  ShadowView.m
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/26.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import "ShadowView.h"
//#import <QuartzCore/QuartzCore>

@implementation ShadowView

-(instancetype)init{
    
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
//    self.layer.shadowOpacity = 1;// 阴影透明度
//    
//    self.layer.shadowColor = [UIColor redColor].CGColor;// 阴影的颜色
//    
//    self.layer.shadowRadius = 100;// 阴影扩散的范围控制
//    
//    self.layer.shadowOffset = CGSizeMake(10, 10);// 阴影的范围
}


@end
