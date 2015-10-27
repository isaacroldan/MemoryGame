//
//  ShareViewCollectionViewDataSource.m
//  MemoryGame
//
//  Created by         on 27/10/15.
//  Copyright © 2015  . All rights reserved.
//

#import "ShareViewCollectionViewDataSource.h"
#import "TrackCell.h"
#import "GameController.h"
#import "Track.h"

@interface ShareViewCollectionViewDataSource()
@property (nonatomic, strong) GameController *gameController;
@end

@implementation ShareViewCollectionViewDataSource

- (id)initWithController:(GameController *)controller items:(NSArray *)items
{
    self = [super init];
    self.gameController = controller;
    self.items = items;
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TrackCell *cell = (TrackCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (self.items.count == 0) {
        [cell configureWithImageURL:nil];
    }
    else {
        Track *track = self.items[indexPath.row];
        [cell configureWithImageURL:track.artworkUrl];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TrackCell *cell = (TrackCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.items.count == 0) { return; }
    if ([self.gameController canSelectItemAtIndex:indexPath.row]) {
        [cell flip];
        [self.gameController selectItemAtIndex:indexPath.row];
    }
}


@end
