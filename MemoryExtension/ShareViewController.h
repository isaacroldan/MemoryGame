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
- (void)showMessage:(NSString *)message;
- (void)updateArtistName:(NSString *)artistName;
- (void)reloadView;
- (void)setCollectionViewDataSource:(ShareViewCollectionViewDataSource *)dataSource;

- (void)resetAllCells;
- (void)discoverCellsAtIndex:(NSInteger)firstIndex andIndex:(NSInteger)secondIndex;
- (void)hideCellsAtIndex:(NSInteger)firstIndex andIndex:(NSInteger)secondIndex;

@end
