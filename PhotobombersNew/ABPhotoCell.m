//
//  ABPhotoCell.m
//  PhotoBombers
//
//  Created by Arama Brown on 3/5/16.
//  Copyright (c) 2016 Arama Brown. All rights reserved.
//

#import "ABPhotoCell.h"

@implementation ABPhotoCell


-(id) initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageView];
        
    }
    
    return self;
}

    
    -(void)layoutSubviews {
        
        [super layoutSubviews];
    
        self.imageView.frame = self.contentView.bounds;
    
}




@end
