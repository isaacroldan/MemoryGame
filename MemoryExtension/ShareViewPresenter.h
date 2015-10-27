//
//  ShareViewPresenter.h
//  MemoryGame
//
//  Created by Isaac Roldán Armengol on 27/10/15.
//  Copyright © 2015 Isaac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShareViewController;

@interface ShareViewPresenter : NSObject
- (id)initWithView:(ShareViewController *)controller;
- (void)viewDidLoadWithContext:(NSExtensionContext *)extensionContext;
@end
