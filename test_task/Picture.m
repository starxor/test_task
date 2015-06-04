
//
//  Picture.m
//  test_task
//
//  Created by Станислав Старжевский on 04.06.15.
//  Copyright (c) 2015 Stanislav Starzhevskiy. All rights reserved.
//

#import "Picture.h"

@interface Picture ()

@property (strong, nonatomic) NSURL *url;

@end

@implementation Picture

+ (instancetype)randomPicture
{
    int r_num1 = (arc4random_uniform(140)+20) * 10;
    int r_num2 = (arc4random_uniform(140)+20) * 10;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.placecage.com/%d/%d",r_num1,r_num2]];
    
    Picture *r_picture = [Picture new];
    r_picture.url = url;
    
    return r_picture;
}

- (NSString *)description
{
    return [[super description] stringByAppendingFormat:@"%@",self.url.absoluteString];
}

- (NSURL *)pictureURL
{
    return _url;
}

@end
