//
//  ABPhotoCell.h
//  PhotoBombers
//
//  Created by Arama Brown on 3/5/16.
//  Copyright (c) 2016 Arama Brown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABPhotoCell : UICollectionViewCell

//UITableViewCell already has an imageview, but UICollectionViewCell doesn't so we have to add one 

@property (nonatomic) UIImageView *imageView;


@end
