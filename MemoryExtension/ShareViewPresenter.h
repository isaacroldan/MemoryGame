//
//  ShareViewPresenter.h
//  MemoryGame
//
//  Created by         on 27/10/15.
//  Copyright © 2015  . All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShareViewController;

@interface ShareViewPresenter : NSObject
- (id)initWithView:(ShareViewController *)controller;
- (void)viewDidLoadWithContext:(NSExtensionContext *)extensionContext;
@end
