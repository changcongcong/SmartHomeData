//
//  LoginModel.h
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/14.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginResultModel : NSObject

@property(nonatomic,copy)NSString *accesstoken;
@property(nonatomic,copy)NSString *createBy;
@property(nonatomic,copy)NSString *createDate;
@property(nonatomic,copy)NSString *gender;
@property(nonatomic,copy)NSString *housingId;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *idCard;
@property(nonatomic,copy)NSString *imeicode;
@property(nonatomic,copy)NSString *lockNumber;
@property(nonatomic,copy)NSString *loginName;
@property(nonatomic,copy)NSString *modifyBy;
@property(nonatomic,copy)NSString *modifyDate;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *nowDate;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *photo;
@property(nonatomic,copy)NSString *photologinDate;
@property(nonatomic,copy)NSString *request_user_id;
@property(nonatomic,copy)NSString *roomInfo;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *version;
@property(nonatomic,copy)NSString *is_first_login;

@property(nonatomic,copy)NSMutableArray *contract;
@property(nonatomic,copy)NSMutableArray *housing;
@property(nonatomic,copy)NSMutableArray *requestUser;

@end

@interface LoginModel : NSObject

@property(nonatomic,copy)NSString *code;

@property(nonatomic,copy) NSMutableArray *results;




@end
