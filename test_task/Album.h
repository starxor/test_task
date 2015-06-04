//
//  Album.h
//  test_task
//
//  Created by Станислав Старжевский on 04.06.15.
//  Copyright (c) 2015 Stanislav Starzhevskiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Picture.h"

@interface Album : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic, getter=isVisible) BOOL visible;
@property (strong, nonatomic) NSMutableArray *pictures;

+ (instancetype)randomAlbum:(NSString *)name size:(int)size;

@end
