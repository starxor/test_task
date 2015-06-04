//
//  CollectionViewController.h
//  test_task
//
//  Created by Станислав Старжевский on 04.06.15.
//  Copyright (c) 2015 Stanislav Starzhevskiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CollectionViewControllerDelegate <NSObject>

- (void)selectedCountDidChange;

@end

@interface CollectionViewController : UICollectionViewController

@property (weak, nonatomic) id<CollectionViewControllerDelegate>delegate;
@property (nonatomic) int selectedPhotosCount;

@end
