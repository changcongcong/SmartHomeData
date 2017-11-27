//
//  SMTool.m
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/14.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import "SMTool.h"

@implementation SMTool

+(NSString *)getSercure:(NSString *)str{
    char a[str.length];        /*要加密的密码*/
    strcpy(a,(char *)[str UTF8String]);
    int i;
    /*加密代码*/
    for(i=0;a[i]!='\0';i++)
        a[i]=a[i]^'#';
    return [NSString stringWithFormat:@"%s",a];
}

+(NSString *)getNowTimeTimestamp{
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%lld", (long long)[datenow timeIntervalSince1970] * 1000];
    return timeSp;
}

+(NSString *)getIMEICODE{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

/*
 周边加阴影，并且同时圆角
 */
+ (void)addShadowToView:(UIView *)view
            withOpacity:(float)shadowOpacity
           shadowRadius:(CGFloat)shadowRadius
        andCornerRadius:(CGFloat)cornerRadius
{
    //左边
//    UIView *viewShadowLeft=[[UIView alloc]init];
//    viewShadowLeft.backgroundColor=[UIColor colorWithHexString:@"f57f27" alpha:shadowOpacity];
//    [view addSubview:viewShadowLeft];
//    [viewShadowLeft mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(view);
//        make.left.equalTo(view).offset(-shadowRadius);
//        make.top.equalTo(view).offset(-shadowRadius);
//    }];
    
//    view.layer.shadowColor = [UIColor colorWithHexString:@"f57f27"].CGColor;
//    //shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//    view.layer.shadowOffset = CGSizeMake(4,4);
//    //阴影透明度，默认0
//    view.layer.shadowOpacity = 0.8;
//    //阴影半径，默认3
//    view.layer.shadowRadius = 4;
    
    //////// shadow /////////
//    CALayer *shadowLayer = [CALayer layer];
//    shadowLayer.frame = view.layer.frame;
//    
//    shadowLayer.shadowColor = [UIColor colorWithHexString:@"f57f27"].CGColor;//shadowColor阴影颜色
//    shadowLayer.shadowOffset = CGSizeMake(0, 45);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
//    shadowLayer.shadowOpacity = shadowOpacity;//0.8;//阴影透明度，默认0
//    shadowLayer.shadowRadius = shadowRadius;//8;//阴影半径，默认3
//    
//    //路径阴影
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    
//    float width = shadowLayer.bounds.size.width;
//    float height = shadowLayer.bounds.size.height;
//    float x = shadowLayer.bounds.origin.x;
//    float y = shadowLayer.bounds.origin.y;
//    
//    CGPoint topLeft      = shadowLayer.bounds.origin;
//    CGPoint topRight     = CGPointMake(x + width, y);
//    CGPoint bottomRight  = CGPointMake(x + width, y + height);
//    CGPoint bottomLeft   = CGPointMake(x, y + height);
//    
//    CGFloat offset = -1.f;
//    [path moveToPoint:CGPointMake(topLeft.x - offset, topLeft.y + cornerRadius)];
//    [path addArcWithCenter:CGPointMake(topLeft.x + cornerRadius, topLeft.y + cornerRadius) radius:(cornerRadius + offset) startAngle:M_PI endAngle:M_PI_2 * 3 clockwise:YES];
//    [path addLineToPoint:CGPointMake(topRight.x - cornerRadius, topRight.y - offset)];
//    [path addArcWithCenter:CGPointMake(topRight.x - cornerRadius, topRight.y + cornerRadius) radius:(cornerRadius + offset) startAngle:M_PI_2 * 3 endAngle:M_PI * 2 clockwise:YES];
//    [path addLineToPoint:CGPointMake(bottomRight.x + offset, bottomRight.y - cornerRadius)];
//    [path addArcWithCenter:CGPointMake(bottomRight.x - cornerRadius, bottomRight.y - cornerRadius) radius:(cornerRadius + offset) startAngle:0 endAngle:M_PI_2 clockwise:YES];
//    [path addLineToPoint:CGPointMake(bottomLeft.x + cornerRadius, bottomLeft.y + offset)];
//    [path addArcWithCenter:CGPointMake(bottomLeft.x + cornerRadius, bottomLeft.y - cornerRadius) radius:(cornerRadius + offset) startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
//    [path addLineToPoint:CGPointMake(topLeft.x - offset, topLeft.y + cornerRadius)];
//    
//    //设置阴影路径
//    shadowLayer.shadowPath = path.CGPath;
//    
//    //////// cornerRadius /////////
//    view.layer.cornerRadius = cornerRadius;
//    view.layer.masksToBounds = YES;
//    view.layer.shouldRasterize = YES;
//    view.layer.rasterizationScale = [UIScreen mainScreen].scale;
//    
//    [view.superview.layer insertSublayer:shadowLayer below:view.layer];
}

@end
