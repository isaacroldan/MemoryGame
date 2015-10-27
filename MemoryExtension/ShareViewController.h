//
//  ShareViewController.h
//  MemoryExtension
//
//  Created by Isaac Roldán Armengol on 24/10/15.
//  Copyright © 2015 Isaac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Foundation/Foundation.h>

@class ShareViewCollectionViewDataSource;

@interface ShareViewController : UIViewController

/**
 Show an alert in the view that will disappear in a few seconds.
 */
- (void)showMessage:(NSString *)message;

/**
 Set the current artist name. It will be displayed at the top of the view.
 */
- (void)updateArtistName:(NSString *)artistName;

/**
 Hide any alert still showing and reload the CollectionView
 */
- (void)reloadView;

/**
 Set the CollectionView dataSource and delegate
 */
- (void)setCollectionViewDataSource:(ShareViewCollectionViewDataSource *)dataSource;

/**
 Flip all cells to show the back of the card.
 */
- (void)resetAllCells;

/**
 Flip the cells at the given index to show the front of the card
 */
- (void)discoverCellsAtIndex:(NSInteger)firstIndex andIndex:(NSInteger)secondIndex;

/**
 Flip the cells at the given index to show the back of the card
 */
- (void)hideCellsAtIndex:(NSInteger)firstIndex andIndex:(NSInteger)secondIndex;
@end
