//
//  SMTool.h
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/14.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMTool : NSObject

+(NSString *)timeWithTimeIntervalString:(NSString *)timeString;

+(NSString *)getSercure:(NSString *)str;

+(NSString *)getNowTimeTimestamp;

+(NSString *)getIMEICODE;

+ (void)addShadowToView:(UIView *)view
            withOpacity:(float)shadowOpacity
           shadowRadius:(CGFloat)shadowRadius
        andCornerRadius:(CGFloat)cornerRadius;

@end
