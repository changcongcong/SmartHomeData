//
//  GuaranteeDetailModel.m
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/26.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import "GuaranteeDetailModel.h"

@implementation GuaranteeDetailDetailModel


@end

@implementation GuaranteeDetailModel

// 包含
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"results" : [GuaranteeDetailDetailModel class]
             };
}


@end
