//
//  ShareViewController.m
//  MemoryExtension
//
//  Created by Isaac Roldán Armengol on 24/10/15.
//  Copyright © 2015 Isaac. All rights reserved.
//

#import "ShareViewController.h"
#import "MemoryGameKit.h"
#import "TrackCell.h"
#import <MBProgressHUD/MBProgressHUD.h>


@interface ShareViewController()  <UICollectionViewDataSource, UICollectionViewDelegate, GameControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) GameController *gameController;
@property (nonatomic, strong) NSArray *tracks;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"received context: %@", self.extensionContext);
}

- (void)viewDidAppear:(BOOL)animated
{
    NSString *permalink = @"https://soundcloud.com/colinparkermusic/thomas-jack-rivers-colin-parker-remix";
    self.gameController = [GameController new];
    self.gameController.delegate = self;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"Preparing your game...";
    [self.gameController startGameWithPermalink:permalink completion:^(NSArray *items) {
        self.tracks = items;
        [self.collectionView reloadData];
        [hud hide:YES];
    }];
}

- (BOOL)isContentValid
{
    return YES;
}


- (IBAction)closeGame:(id)sender
{
    [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
}


#pragma mark - GameController delegate

- (void)didFinishGame
{
    
}

- (void)didFoundMatchAtIndex:(NSInteger)firstIndex and:(NSInteger)secondIndex
{
    
}


- (void)didFailToFindMatchAtIndex:(NSInteger)firstIndex and:(NSInteger)secondIndex
{
    TrackCell *firstCell = (TrackCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:firstIndex inSection:0]];
    TrackCell *secondCell = (TrackCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:secondIndex inSection:0]];
   [firstCell performSelector:@selector(flip) withObject:nil afterDelay:0.5];
    [secondCell performSelector:@selector(flip) withObject:nil afterDelay:0.5];
}



#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 16;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TrackCell *cell = (TrackCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (self.tracks.count == 0) {
        cell.label.text = @"00";
    }
    else {
        Track *track = self.tracks[indexPath.row];
        cell.label.text = [track.trackID stringValue];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TrackCell *cell = (TrackCell *)[collectionView cellForItemAtIndexPath:indexPath];

    if (self.tracks.count == 0) { return; }
    
    if ([self.gameController selectItemAtIndex:indexPath.row]) {
        [cell flip];
    }
    
}

- (NSArray *)tracks
{
    if (!_tracks) {
        _tracks = @[];
    }
    return _tracks;
}


@end
