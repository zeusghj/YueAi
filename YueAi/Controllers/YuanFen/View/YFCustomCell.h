//
//  YFCustomCell.h
//  YueAi
//
//  Created by 郭洪军 on 5/27/16.
//  Copyright © 2016 郭洪军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFCustomCellModel : NSObject

@property (copy, nonatomic) NSString* uid;
@property (copy, nonatomic) NSString* iconUrl;

@end

@interface YFCustomCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) YFCustomCellModel* model;

@end


