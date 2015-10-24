//
//  TrackCell.m
//  MemoryGame
//
//  Created by Isaac Roldán Armengol on 24/10/15.
//  Copyright © 2015 Isaac. All rights reserved.
//

#import "TrackCell.h"
@interface TrackCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (nonatomic) BOOL flipped;
    
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

- (void)flip
{
    [UIView transitionWithView:self.contentView duration:0.3 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        self.flipped ? [self showBack] : [self showFront];
    } completion:^(BOOL finished) {
        self.flipped = !self.flipped;
    }];
}

- (void)showFront
{
    [self.contentView insertSubview:self.imageView aboveSubview:self.backImageView];
}


- (void)showBack
{
    [self.contentView insertSubview:self.backImageView aboveSubview:self.imageView];
}

@end
