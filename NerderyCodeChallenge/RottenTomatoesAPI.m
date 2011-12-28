//
//  RottenTomatoesAPIKey.m
//  NerderyCodeChallenge
//
//  Created by Sergey Klimov on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RottenTomatoesAPI.h"

NSString * const RottenTomatoesAPIKey = @"ambsyq4xzyr29nzu3r7aer52";
NSString * const RottenTomatoesBaseUrl = @"http://api.rottentomatoes.com/api/public";
NSString * const RottenTomatoesVersion = @"v1.0";


@interface RottenTomatoesAPI()
+(NSURL*) constructApiUrlWithParams:(NSString*) params;
@end

@implementation RottenTomatoesAPI

+(NSURL*) constructApiUrlWithParams:(NSString*) params {
    return [NSURL URLWithString:
            [NSString stringWithFormat:@"%@/%@/%@", RottenTomatoesBaseUrl, RottenTomatoesVersion, params]];
}

+(NSURL*) topBoxOfficeMoviesLimit:(NSUInteger)limit {
    return [self constructApiUrlWithParams:[NSString stringWithFormat:@"lists/movies/box_office.json?apikey=%@&limit=%d", RottenTomatoesAPIKey, limit]];
}
@end