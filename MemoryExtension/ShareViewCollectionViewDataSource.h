//
//  ShareViewCollectionViewDataSource.h
//  MemoryGame
//
//  Created by Isaac Roldán Armengol on 27/10/15.
//  Copyright © 2015 Isaac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class  GameController;

@interface ShareViewCollectionViewDataSource : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *items;
- (id)initWithController:(GameController *)controller items:(NSArray *)items;
@end
