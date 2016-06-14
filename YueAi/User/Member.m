//
//  Member.m
//  YueAi
//
//  Created by 郭洪军 on 6/14/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import "Member.h"

@implementation Member

- (instancetype)init{
    self = [super init];
    
    if (self) {  //暂时先用本体图片代替
        _iconImgUrl = @"meinv1_icon";
        _bigImgUrls = @[@"http://pic25.nipic.com/20121201/8761817_195550674000_2.jpg", @"http://images.17173.com/2012/news/2012/11/28/2012cpb1128hy33s.jpg"];
    }
    
    return self;
}

@end
