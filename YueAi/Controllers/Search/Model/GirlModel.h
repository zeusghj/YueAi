//
//  GirlModel.h
//  YueAi
//
//  Created by 郭洪军 on 6/24/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GirlModel : NSObject

@property (copy, nonatomic) NSString* iconUrl;
@property (copy, nonatomic) NSString* name;
@property (copy, nonatomic) NSString* age;
@property (copy, nonatomic) NSString* address;
@property (copy, nonatomic) NSString* height;
@property (copy, nonatomic) NSString* income;
@property (copy, nonatomic) NSString* distance;
@property (strong, nonatomic)NSArray* tags;


@end
