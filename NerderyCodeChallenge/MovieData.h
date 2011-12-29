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

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * criticsScore;
@property (nonatomic, retain) NSString * criticsFreshness;
@property (nonatomic, retain) NSString * synopsis;
@property (nonatomic, retain) NSNumber * runtime;
@property (nonatomic, retain) NSData * poster;
@property (nonatomic, retain) NSSet *characters;
@property (nonatomic, retain) NSSet *actors;
@end

@interface MovieData (CoreDataGeneratedAccessors)

- (void)addCharactersObject:(NSManagedObject *)value;
- (void)removeCharactersObject:(NSManagedObject *)value;
- (void)addCharacters:(NSSet *)values;
- (void)removeCharacters:(NSSet *)values;

- (void)addActorsObject:(NSManagedObject *)value;
- (void)removeActorsObject:(NSManagedObject *)value;
- (void)addActors:(NSSet *)values;
- (void)removeActors:(NSSet *)values;

+ (MovieData*)saveMovie:(Movie*) movie;
+ (void)unsaveMovie:(Movie*) movie;
+ (NSSet*) savedMoviesNames;
+(Movie*) savedMovieAtIndex:(NSUInteger) index;
-(Movie*) asMovie;

@end
