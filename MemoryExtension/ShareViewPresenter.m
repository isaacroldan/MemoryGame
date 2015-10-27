//
//  ShareViewPresenter.m
//  MemoryGame
//
//  Created by Isaac Roldán Armengol on 27/10/15.
//  Copyright © 2015 Isaac. All rights reserved.
//

#import "ShareViewPresenter.h"
#import "ShareViewController.h"
#import "GameController.h"
#import "Track.h"
#import <UIKit/UIKit.h>
#import "ShareViewCollectionViewDataSource.h"

@interface ShareViewPresenter() <GameControllerDelegate>
@property (nonatomic, strong) GameController *gameController;
@property (nonatomic, strong) ShareViewController *viewController;
@property (nonatomic, strong) NSArray *tracks;
@property (nonatomic, strong) ShareViewCollectionViewDataSource *dataSource;
@end

@implementation ShareViewPresenter


- (id)initWithView:(ShareViewController *)controller
{
    self = [super init];
    self.viewController = controller;
    return self;
}

- (void)viewDidLoadWithContext:(NSExtensionContext *)extensionContext
{
    self.gameController = [GameController new];
    self.gameController.delegate = self;
   
    __weak typeof(self) welf = self;
    [self extractPermalinkFromContext:extensionContext withCompletion:^(NSString *permalink) {
        [welf.gameController startGameWithPermalink:permalink completion:^(NSArray *items, NSError *error) {
            if (error) {
                [welf.viewController showMessage:@"Invalid user or not enough tracks :("];
                [welf.viewController updateArtistName:@"Choose another artist!"];
                
            }
            else {
                welf.tracks = items;
                welf.dataSource = [[ShareViewCollectionViewDataSource alloc] initWithController:welf.gameController items:items];
                [welf.viewController setCollectionViewDataSource:welf.dataSource];
                [welf.viewController reloadView];
                Track *first = [items firstObject];
                [welf.viewController updateArtistName:[NSString stringWithFormat:@"%@ Memory Game!", first.username]];
            }
        }];
    }];
}

- (void)extractPermalinkFromContext:(NSExtensionContext *)extensionContext withCompletion:(void (^)(NSString *permalink))completion
{
    for (NSExtensionItem *object in extensionContext.inputItems) {
        for (NSItemProvider *item in object.attachments) {
            if ([item hasItemConformingToTypeIdentifier:@"public.url"]) {
                [item loadItemForTypeIdentifier:@"public.url" options:nil completionHandler:^(NSURL *item, NSError * error) {
                    completion(item.absoluteString);
                }];
            }
        }
    }
}


#pragma mark - GameController delegate

- (void)didFinishGame
{
    [self.viewController showMessage:@"Awesome!!"];
    [self.viewController resetAllCells];
    NSArray *newItems = [self.gameController restart];
    self.dataSource.items = newItems;
    [self.viewController reloadView];
}

- (void)didFoundMatchAtIndex:(NSInteger)firstIndex and:(NSInteger)secondIndex
{
    [self.viewController discoverCellsAtIndex:firstIndex andIndex:secondIndex];
}

- (void)didFailToFindMatchAtIndex:(NSInteger)firstIndex and:(NSInteger)secondIndex
{
    [self.viewController hideCellsAtIndex:firstIndex andIndex:secondIndex];
}


#pragma mark - Lazy

- (NSArray *)tracks
{
    
    if (!_tracks) {
        _tracks = @[];
    }
    return _tracks;
}

@end
