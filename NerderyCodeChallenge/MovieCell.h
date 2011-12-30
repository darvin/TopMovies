//
//  MovieCell.h
//  NerderyCodeChallenge
//
//  Created by Sergey Klimov on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

#define RIGHT_MARGIN 28
#define GAP_BETWEEN_TITLE_AND_RATING 5

@interface MovieCell : UITableViewCell



@property (strong, nonatomic) IBOutlet UILabel * name;
@property (strong, nonatomic) IBOutlet UIImageView * poster;
@property (strong, nonatomic) IBOutlet UIImageView * rating;
@property (strong, nonatomic) IBOutlet UIButton * favorite;
@property (strong, nonatomic) IBOutlet UIProgressView * score;
@property (strong, nonatomic) Movie * movie;

@end
