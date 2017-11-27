//
//  WELineView.m
//  waterelephantloan
//
//  Created by waterpant on 2017/9/4.
//  Copyright © 2017年 waterelephant. All rights reserved.
//

#import "WELineView.h"

//画一像素的线
#define SINGLE_LINE_WIDTH (1/[UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET ((1/[UIScreen mainScreen].scale)/2)

@implementation WELineView

#pragma mark - 初始化 -
-(instancetype)init{
    
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
}

-(void)setLineDirection:(LineStyle)lineDirection{
    if (lineDirection==LineStyleHorizontal) {
        UIView *viewLine = [[UIView alloc] init];
        viewLine.backgroundColor = [UIColor colorWithHexString:@"d5d5d5"];
        [self addSubview:viewLine];
        [viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(1- SINGLE_LINE_ADJUST_OFFSET);
            make.height.mas_equalTo(SINGLE_LINE_WIDTH);
        }];
    }
    
    if (lineDirection==LineStyleVertical) {
        UIView *viewLine = [[UIView alloc] init];
        viewLine.backgroundColor = [UIColor colorWithHexString:@"d5d5d5"];
        [self addSubview:viewLine];
        [viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self).offset(1- SINGLE_LINE_ADJUST_OFFSET);
            make.width.mas_equalTo(SINGLE_LINE_WIDTH);
        }];
    }
    
}

@end

