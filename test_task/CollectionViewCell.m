
//
//  CollectionViewCell.m
//  test_task
//
//  Created by Станислав Старжевский on 04.06.15.
//  Copyright (c) 2015 Stanislav Starzhevskiy. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell()



@end

@implementation CollectionViewCell

- (void)toggleSelectionOverlay
{
    if (!_transparentOverlayView) {
        _transparentOverlayView = [[UIView alloc] initWithFrame:self.bounds];
        _transparentOverlayView.backgroundColor = [UIColor colorWithRed:0
                                                                  green:1
                                                                   blue:0
                                                                  alpha:.6f];
        _transparentOverlayView.hidden = YES;
        
        [self addSubview:_transparentOverlayView];
    }
    
    _transparentOverlayView.hidden = !_transparentOverlayView.hidden;
}

@end
