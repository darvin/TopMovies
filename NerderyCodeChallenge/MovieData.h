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

//Contains Movie variant of current saved movies
+ (NSMutableArray*) movies;

//Saves Movie as MovieData
+ (MovieData*)saveMovie:(Movie*) movie;

//Deletes MovieData for Movie
+ (void)unsaveMovie:(Movie*) movie;

//Returns set of saved movies' ids
+ (NSSet*) savedMoviesIds;

//Returns Movie for MovieData
- (Movie*) asMovie;

@end
