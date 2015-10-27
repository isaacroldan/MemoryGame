//
//  TrackCell.m
//  MemoryGame
//
//  Created by         on 24/10/15.
//  Copyright © 2015  . All rights reserved.
//

#import "TrackCell.h"
#import <WebImage/WebImage.h>

@interface TrackCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (nonatomic) BOOL flipped;
@property (nonatomic) BOOL flipping;

@end


@implementation TrackCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.imageView.layer.cornerRadius = 10;
    self.imageView.layer.masksToBounds = true;
    self.imageView.clipsToBounds = true;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.backImageView.layer.cornerRadius = 10;
    self.backImageView.layer.masksToBounds = true;
    self.backImageView.clipsToBounds = true;
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}


#pragma mark - Configure cell

- (void)configureWithImageURL:(NSString *)image
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:image]];
}


#pragma mark - Flip cell methods

- (void)flip
{
    [self discoverCard:!self.flipped];
}

- (void)showFront
{
    [self discoverCard:YES];
}

- (void)showBack
{
    [self discoverCard:NO];
}

- (void)discoverCard:(BOOL)discover
{
    if (self.flipping) { return; }
    self.flipping = YES;
    [UIView transitionWithView:self.contentView duration:0.3 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        !discover ?
        [self.contentView insertSubview:self.backImageView aboveSubview:self.imageView] :
        [self.contentView insertSubview:self.imageView aboveSubview:self.backImageView];
    } completion:^(BOOL finished) {
        self.flipped = discover;
        self.flipping = NO;
    }];
}

@end
