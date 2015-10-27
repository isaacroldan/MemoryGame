//
//  ShareViewCollectionViewDataSource.h
//  MemoryGame
//
//  Created by         on 27/10/15.
//  Copyright © 2015  . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class  GameController;

@interface ShareViewCollectionViewDataSource : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *items;
- (id)initWithController:(GameController *)controller items:(NSArray *)items;
@end
