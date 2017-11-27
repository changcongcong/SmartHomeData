//
//  GuaranteeDetailModel.h
//  SmartHome
//
//  Created by 常丛丛 on 2017/11/26.
//  Copyright © 2017年 SmartHome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuaranteeDetailDetailModel : NSObject

@property(nonatomic,copy)NSString *commentDate ;
@property(nonatomic,copy)NSString *description ;
@property(nonatomic,copy)NSString *evaluate;
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *pathes ;
@property(nonatomic,copy)NSString *repairTime ;
@property(nonatomic,copy)NSString *repairTimes ;
@property(nonatomic,copy)NSString *repair_position;
@property(nonatomic,copy)NSString *repair_project;
@property(nonatomic,copy)NSString *repair_type;
@property(nonatomic,copy)NSString *score;
@property(nonatomic,copy)NSString *status ;
@property(nonatomic,copy)NSString *statusVal ;
@property(nonatomic,copy)NSString *time_slot;


@end

@interface GuaranteeDetailModel : NSObject

@property(nonatomic,copy)NSString *code;

@property(nonatomic,copy) NSMutableArray *results;

@end
