//
//  Picture.h
//  test_task
//
//  Created by Станислав Старжевский on 04.06.15.
//  Copyright (c) 2015 Stanislav Starzhevskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Picture : NSObject

@property (nonatomic, getter=isSelected) BOOL selected;

+ (instancetype)randomPicture;

- (NSURL *)pictureURL;

@end
