//
//  Movie.m
//  NerderyCodeChallenge
//
//  Created by Sergey Klimov on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Movie.h"
#import "AFNetworking.h"
#import "RottenTomatoesAPI.h"

@implementation Movie
@synthesize properties = _properties;

-(id) initWithProperties:(NSDictionary*) properties; {
    if (self = [super init]) {
        self.properties = properties;
    }
    return self;
}

-(NSString*) name {
    return [self.properties objectForKey:@"title"];
}

-(NSUInteger) criticsScore {
    return [[[self.properties objectForKey:@"ratings"] objectForKey:@"critics_score"] intValue];
}

-(UIImage*) ratingImage {
    return [UIImage imageNamed:[[self.properties objectForKey:@"mpaa_rating"] lowercaseString]];
}


-(NSURL*) urlPosterWithSize:(MoviePosterSize) size {
    NSString* sizeName = nil;
    switch (size) {
        case MoviePosterSizeDetailed:
            sizeName = @"detailed";
            break;
        case MoviePosterSizeOriginal:
            sizeName = @"original";
            break;
        case MoviePosterSizeProfile:
            sizeName = @"profile";
            break;
        case MoviePosterSizeThumbnail:
            sizeName = @"thumbnail";
            break;
            
        default:
            break;
    }
    return [NSURL URLWithString:[[self.properties objectForKey:@"posters"] objectForKey:sizeName]];
}

@end
