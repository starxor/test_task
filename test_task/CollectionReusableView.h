//
//  CollectionReusableView.h
//  test_task
//
//  Created by Станислав Старжевский on 04.06.15.
//  Copyright (c) 2015 Stanislav Starzhevskiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end
