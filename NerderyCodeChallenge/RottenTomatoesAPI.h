//
//  RottenTomatoesAPIKey.h
//  NerderyCodeChallenge
//
//  Created by Sergey Klimov on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

extern NSString * const RottenTomatoesAPIKey;
extern NSString * const RottenTomatoesBaseUrl;
extern NSString * const RottenTomatoesVersion;


@interface RottenTomatoesAPI : NSObject

+(NSURL*) topBoxOfficeMoviesLimit:(NSUInteger)limit;

@end