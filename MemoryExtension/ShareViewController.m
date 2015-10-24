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

@interface ShareViewController()  <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"received context: %@", self.extensionContext);
    NSString *permalink = @"https://soundcloud.com/colinparkermusic/thomas-jack-rivers-colin-parker-remix";
    [[APIClient resolveFromPermalink:permalink] subscribeNext:^(id x) {
        NSLog(@"received %@", x);
    }];
}

- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    
    return YES;
}

- (void)didSelectPost {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
}

- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    return @[];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 16;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TrackCell *cell = (TrackCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TrackCell *cell = (TrackCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell flip];
}


@end
