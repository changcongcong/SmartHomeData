//
//  GuaranteeModel.h
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/25.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuaranteeModel : NSObject

@property(nonatomic,copy) NSString *createDate;
@property(nonatomic,copy) NSString *id;
@property(nonatomic,copy) NSString *pathes;
@property(nonatomic,copy) NSString *repairTime;
@property(nonatomic,copy) NSString *repairTimes ;
@property(nonatomic,copy) NSString *repair_position;
@property(nonatomic,copy) NSString *repair_project;
@property(nonatomic,copy) NSString *repair_type;
@property(nonatomic,copy) NSString *smallPathes;
@property(nonatomic,copy) NSString *status;
@property(nonatomic,copy) NSString *statusVal;
@property(nonatomic,copy) NSString *time_slot;
@property(nonatomic,copy) NSString *desc;

@end
