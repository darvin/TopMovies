//
//  MovieCell.m
//  NerderyCodeChallenge
//
//  Created by Sergey Klimov on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieCell.h"
#import "Movie.h"
#import "UIImageView+AFNetworking.h"

@implementation MovieCell
@synthesize name, poster, rating, score;
@synthesize movie=_movie;


-(void) setMovie:(Movie *)movie {
    _movie = movie;
    self.name.text = movie.name;
    [self.rating setImage:[movie ratingImage]];
    NSLog(@"%@ - %@",movie.name, [movie.properties objectForKey:@"mpaa_rating"]);
    self.score.progress = movie.criticsScore/100.0;
    [self.poster setImageWithURL:[self.movie urlPosterWithSize:MoviePosterSizeThumbnail]];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    CGFloat ratingWidth = self.rating.image.size.width;
    self.name.frame = CGRectMake(self.name.frame.origin.x, self.name.frame.origin.y, self.frame.size.width - self.name.frame.origin.x-GAP_BETWEEN_TITLE_AND_RATING-RIGHT_MARGIN-ratingWidth, self.name.frame.size.height);
    [self.name adjustsFontSizeToFitWidth];

    
    CGSize textSize = [[self.name text] sizeWithFont:[self.name font]];
    
    CGRect labelRect = self.name.frame;
    
    CGFloat textWidth = (textSize.width<labelRect.size.width) ? textSize.width : labelRect.size.width;
    
    CGFloat ratingX = labelRect.origin.x+textWidth + GAP_BETWEEN_TITLE_AND_RATING;
    
    
    self.rating.frame = CGRectMake(ratingX, self.rating.frame.origin.y, ratingWidth, self.rating.frame.size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
