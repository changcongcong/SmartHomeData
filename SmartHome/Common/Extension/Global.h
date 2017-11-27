//
//  Global.h
//  Hospital
//
//  Created by by Heliulin on 15/5/19.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"

@interface Global : NSObject
+(instancetype)sharedInstance;

@property(strong,nonatomic)NSString *IMEICODE;
@property(strong,nonatomic)NSString *accesstoken;
@property(strong,nonatomic)LoginModel *model;

@end

