//
//  Album.m
//  test_task
//
//  Created by Станислав Старжевский on 04.06.15.
//  Copyright (c) 2015 Stanislav Starzhevskiy. All rights reserved.
//

#import "Album.h"

@implementation Album

+ (instancetype)randomAlbum:(NSString *)name size:(int)size
{
    Album *r_album = [Album new];
    r_album.pictures = [NSMutableArray array];
    
    [r_album.pictures setArray:[Album gimmeCage:size]];
    r_album.name = name;
    return r_album;
}

+ (NSArray *)gimmeCage:(int)numberOfCages
{
    NSMutableArray *t_arr = [NSMutableArray array];
    for (int i = 0; i < numberOfCages; i++) {
        [t_arr addObject:[Picture randomPicture]];
    }
    
    return t_arr;
}

- (NSString *)description
{
    return [[super description] stringByAppendingFormat:@"pictures count : %lu ;is Visible : %@",(unsigned long)self.pictures.count, self.isVisible ? @"YES":@"NO"];
}

@end
