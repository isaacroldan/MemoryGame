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
#import "ShareViewPresenter.h"
#import "ShareViewCollectionViewDataSource.h"


@interface ShareViewController()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *artistName;
@property (nonatomic, strong) ShareViewPresenter *presenter;
@property (nonatomic, strong) MBProgressHUD *loadingHud;
@end


@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.presenter viewDidLoadWithContext:self.extensionContext];
    self.loadingHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.loadingHud.mode = MBProgressHUDModeText;
    self.loadingHud.labelText = @"Preparing your game...";
}

- (void)showMessage:(NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    [hud performSelector:@selector(hide:) withObject:@YES afterDelay:3];
}

- (void)reloadView
{
    [self.loadingHud hide:YES];
    [self.collectionView reloadData];
}

- (void)updateArtistName:(NSString *)artistName
{
    self.artistName.text = artistName;
}

- (void)setCollectionViewDataSource:(ShareViewCollectionViewDataSource *)dataSource
{
    self.collectionView.dataSource = dataSource;
    self.collectionView.delegate = dataSource;
}


#pragma mark - Actions

- (IBAction)closeGame:(id)sender
{
    [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
}


#pragma mark - Cell interactions

- (void)resetAllCells
{
    for (int i = 0; i<[self.collectionView numberOfItemsInSection:0]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        TrackCell *cell = (TrackCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        [cell showBack];
    }
}

- (void)discoverCellsAtIndex:(NSInteger)firstIndex andIndex:(NSInteger)secondIndex
{
    TrackCell *firstCell = (TrackCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:firstIndex inSection:0]];
    TrackCell *secondCell = (TrackCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:secondIndex inSection:0]];
    [firstCell performSelector:@selector(showFront) withObject:nil afterDelay:0];
    [secondCell performSelector:@selector(showFront) withObject:nil afterDelay:0];
}


- (void)hideCellsAtIndex:(NSInteger)firstIndex andIndex:(NSInteger)secondIndex
{
    TrackCell *firstCell = (TrackCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:firstIndex inSection:0]];
    TrackCell *secondCell = (TrackCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:secondIndex inSection:0]];
    [firstCell performSelector:@selector(showBack) withObject:nil afterDelay:0.5];
    [secondCell performSelector:@selector(showBack) withObject:nil afterDelay:0.5];
}


#pragma mark - Lazys


- (ShareViewPresenter *)presenter
{
    if (!_presenter) {
        _presenter = [[ShareViewPresenter alloc] initWithView:self];
    }
    return _presenter;
}


@end
