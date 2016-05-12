//
//  ABCollectionViewController.m
//  PhotoBombers
//
//  Created by Arama Brown on 3/3/16.
//  Copyright (c) 2016 Arama Brown. All rights reserved.
//

#import "ABCollectionViewController.h"
#import "ABPhotoCell.h"
#import <SimpleAuth/SimpleAuth.h>

@interface ABCollectionViewController ()
@property(nonatomic) NSString *accessToken;

@end

@implementation ABCollectionViewController

-(instancetype)init {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize= CGSizeMake(106.0, 106.0);
    layout.minimumInteritemSpacing = 1.0;
    layout.minimumLineSpacing = 1.0;
    
    return (self = [super initWithCollectionViewLayout:layout]);
}


-(void) viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"Photo Bombers";
    
    [self.collectionView registerClass:[ABPhotoCell class] forCellWithReuseIdentifier:@"photo"];
    
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.accessToken = [userDefaults objectForKey:@"accessToken"];
    
    if (self.accessToken ==nil) {
    
    [SimpleAuth authorize:@"instagram" completion:^(NSDictionary *responseObject, NSError *error) {
    
        
        NSString *accessToken = responseObject[@"credentials"][@"token"];
        //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];//escaping \/
        [userDefaults setObject:accessToken forKey:@"accessToken"];
        [userDefaults synchronize];
    }];
    }else {
        NSURLSession *session = [NSURLSession sharedSession];
       // NSString *urlString= [[NSString alloc]initWithFormat:@"https://api.instagram.com/v1/tags/selfie/media/recent?access_token=%@", self.accessToken];
//        NSString *urlString= [[NSString alloc]initWithFormat:@"https://api.instagram.com/v1/tags/cat/media/recent?access_token=%@", self.accessToken];
        NSString *urlString= [[NSString alloc]initWithFormat:@"https://api.instagram.com/v1/tags/motivation/media/recent?access_token=%@&count=20", self.accessToken];

        NSURL *url = [[NSURL alloc]initWithString:urlString];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error){
            NSData *data = [[NSData alloc]initWithContentsOfURL:location];
            NSDictionary *responseDictionary= [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];;
            NSArray *photos = [responseDictionary valueForKeyPath:@"data.images.standard_resolution.url"];
            
            NSLog(@"photos: %@", photos);
            
//            NSString *text = [[NSString alloc]initWithContentsOfURL: location encoding: NSUTF8StringEncoding error:nil];
//            NSLog (@"text: %@", text);
//        
            
       }];
        [task resume];
}
}



-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section {
    
    return 12;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    cell.backgroundColor  = [UIColor lightGrayColor];
    
    return cell;
}




@end
