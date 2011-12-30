//
//  MovieData.h
//  NerderyCodeChallenge
//
//  Created by Sergey Klimov on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Movie.h"

@interface MovieData : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSData * poster;
@property (nonatomic, retain) NSData * properties;

@end

@interface MovieData (CoreDataGeneratedAccessors)



+ (MovieData*)saveMovie:(Movie*) movie;
+ (void)unsaveMovie:(Movie*) movie;
+ (NSSet*) savedMoviesIds;
+ (Movie*) savedMovieAtIndex:(NSUInteger) index;
+ (NSUInteger) savedMoviesCount;
- (Movie*) asMovie;

@end
