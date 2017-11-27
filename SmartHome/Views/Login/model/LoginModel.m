//
//  LoginModel.m
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/14.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginResultModel

@end

@implementation LoginModel

// 包含
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"results" : [LoginResultModel class]
             };
}

@end
