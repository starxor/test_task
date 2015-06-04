//
//  ViewController.m
//  test_task
//
//  Created by Станислав Старжевский on 04.06.15.
//  Copyright (c) 2015 Stanislav Starzhevskiy. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewController.h"

@interface ViewController () <CollectionViewControllerDelegate>

@property (nonatomic) int selectedPhotosCounter;

@property (weak, nonatomic) CollectionViewController *cvc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%@",self.childViewControllers);
    
    self.cvc = self.childViewControllers.firstObject;
    
    _cvc.delegate = self;
}

- (void)selectedCountDidChange
{
    self.counterLabel.text = [NSString stringWithFormat:@"%d/20",_cvc.selectedPhotosCount];
}

@end
