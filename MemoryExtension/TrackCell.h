//
//  TrackCell.h
//  MemoryGame
//
//  Created by         on 24/10/15.
//  Copyright © 2015  . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrackCell : UICollectionViewCell
- (void)flip;
- (void)showFront;
- (void)showBack;
- (void)discoverCard:(BOOL)discover;
- (void)configureWithImageURL:(NSString *)image;
@end
