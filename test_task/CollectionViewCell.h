//
//  CollectionViewCell.h
//  test_task
//
//  Created by Станислав Старжевский on 04.06.15.
//  Copyright (c) 2015 Stanislav Starzhevskiy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AsyncImageView/AsyncImageView.h>

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet AsyncImageView *imageView;
@property (nonatomic, strong) IBOutlet UIView *transparentOverlayView;
- (void)toggleSelectionOverlay;

@end
