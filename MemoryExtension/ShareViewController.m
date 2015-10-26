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
    self.gameController = [GameController new];
    self.gameController.delegate = self;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"Preparing your game...";
    [self extractPermalinkwithCompletion:^(NSString *permalink) {
        [self.gameController startGameWithPermalink:permalink completion:^(NSArray *items, NSError *error) {
            [hud hide:YES];
            if (error) {
                [self showError:@"Invalid user or not enough tracks :("];
            }
            else {
                self.tracks = items;
                [self.collectionView reloadData];
            }
        }];
    }];
}

- (void)showError:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    [hud performSelector:@selector(hide:) withObject:@YES afterDelay:3];
}

- (void)extractPermalinkwithCompletion:(void (^)(NSString *permalink))completion
{
    for (NSExtensionItem *object in self.extensionContext.inputItems) {
        for (NSItemProvider *item in object.attachments) {
            if ([item hasItemConformingToTypeIdentifier:@"public.url"]) {
                [item loadItemForTypeIdentifier:@"public.url" options:nil completionHandler:^(NSURL *item, NSError * error) {
                    completion(item.absoluteString);
                }];
            }
        }
    }
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
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"Awesome!";
    [hud performSelector:@selector(hide:) withObject:@YES afterDelay:2];
    for (int i = 0; i>self.tracks.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        TrackCell *cell = (TrackCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        [cell flip];
    }
}

- (void)didFoundMatchAtIndex:(NSInteger)firstIndex and:(NSInteger)secondIndex
{
    TrackCell *firstCell = (TrackCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:firstIndex inSection:0]];
    TrackCell *secondCell = (TrackCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:secondIndex inSection:0]];
    [firstCell performSelector:@selector(showFront) withObject:nil afterDelay:0];
    [secondCell performSelector:@selector(showFront) withObject:nil afterDelay:0];
}


- (void)didFailToFindMatchAtIndex:(NSInteger)firstIndex and:(NSInteger)secondIndex
{
    TrackCell *firstCell = (TrackCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:firstIndex inSection:0]];
    TrackCell *secondCell = (TrackCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:secondIndex inSection:0]];
    [firstCell performSelector:@selector(showBack) withObject:nil afterDelay:0.5];
    [secondCell performSelector:@selector(showBack) withObject:nil afterDelay:0.5];
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
        [cell configureWithImageURL:nil];
    }
    else {
        Track *track = self.tracks[indexPath.row];
        [cell configureWithImageURL:track.artworkUrl];
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
