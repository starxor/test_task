//
//  CollectionViewController.m
//  test_task
//
//  Created by Станислав Старжевский on 04.06.15.
//  Copyright (c) 2015 Stanislav Starzhevskiy. All rights reserved.
//

#import "CollectionViewController.h"

#import <AsyncImageView/AsyncImageView.h>
#import "CollectionReusableView.h"
#import "CollectionViewCell.h"

#import "Picture.h"
#import "Album.h"

#define NUM_SECTIONS 50
#define MIN_PICTURES 3
#define MAX_PICTURES 50
#define MAX_SEL_COUNT 20

@interface CollectionViewController ()

@property (strong, nonatomic) NSMutableDictionary *dataSource;

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    [self generateAlbums];
    
}

- (void)generateAlbums
{
    if (!_dataSource) {
        self.dataSource = [NSMutableDictionary dictionary];
    }
    
    [_dataSource removeAllObjects];
    
    for (int i = 0; i < 50 ; i++) {
        //gen name
        NSString *albumName = [NSString stringWithFormat:@"Album %d",i+1];
        
        //gen content
        //let sweet mother of ktulhu pick number of pictures
        int r_num = arc4random_uniform(MAX_PICTURES-2)+3;//50 + 1 upper bound
        //create album
        Album *album = [Album randomAlbum:albumName size:r_num];
        //add album to data source
        if (i == 0) {
            album.visible = YES;
        }
        [_dataSource setObject:album forKey:albumName];
    }
    
    [self.collectionView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.collectionView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return NUM_SECTIONS;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSString *key = [NSString stringWithFormat:@"Album %ld",section+1];
    Album *anAlbum = _dataSource[key];
    int retVal  = anAlbum.isVisible ? (int)anAlbum.pictures.count : 0;
    return retVal;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *key = [NSString stringWithFormat:@"Album %ld",indexPath.section+1];
    Album *anAlbum = _dataSource[key];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    Picture *pic = anAlbum.pictures[indexPath.row];
    if (pic.selected) {
        cell.transparentOverlayView.hidden = NO;
    }else{
        cell.transparentOverlayView.hidden = YES;
    }
    
    [cell bringSubviewToFront:cell.transparentOverlayView];
    
    cell.imageView.crossfadeDuration = 0;
    cell.imageView.image = nil;
    cell.imageView.imageURL = nil;
    cell.imageView.imageURL = [pic pictureURL];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];
    
    NSString *key = [NSString stringWithFormat:@"Album %ld",indexPath.section+1];
    Album *anAlbum = _dataSource[key];
    view.label.text = anAlbum.name;
    
    NSString *b_text = anAlbum.isVisible ? @"Hide" : @"Show";
    
    [view.button setTitle:b_text forState:UIControlStateNormal];
    view.button.tag = indexPath.section;
    if ([view.button allTargets].count == 0) { //of course we can use delegate, but who cares
        [view.button addTarget:self
                        action:@selector(showAlbumFromButton:)
              forControlEvents:UIControlEventTouchUpInside];
    }
    
    return view;
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //higlight/undo selected item
    
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell toggleSelectionOverlay];
    NSString *key = [NSString stringWithFormat:@"Album %ld",indexPath.section+1];
    Album *anAlbum = _dataSource[key];
    Picture *picture = anAlbum.pictures[indexPath.row];
    picture.selected = !picture.selected;
    
    if (picture.selected) {
        _selectedPhotosCount++;
    }else{
        _selectedPhotosCount--;
    }
    
    if (_selectedPhotosCount > 20) {
        [cell toggleSelectionOverlay];
        picture.selected = NO;
        _selectedPhotosCount = 20;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Вы можете выбрать только 20 изображений"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
    
    [self.delegate selectedCountDidChange];
}

#pragma mark - 

- (void)showAlbumFromButton:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    NSString *key = [NSString stringWithFormat:@"Album %ld",tag+1];
    Album *anAlbum = _dataSource[key];
    anAlbum.visible = !anAlbum.visible;
    
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:tag]];
}

@end
