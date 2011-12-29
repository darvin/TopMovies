//
//  ActorData.h
//  NerderyCodeChallenge
//
//  Created by Sergey Klimov on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CharacterData.h"
#import "MovieData.h"
@class MovieData;

@interface ActorData : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *characters;
@property (nonatomic, retain) NSSet *movies;
@end

@interface ActorData (CoreDataGeneratedAccessors)

- (void)addCharactersObject:(NSManagedObject *)value;
- (void)removeCharactersObject:(NSManagedObject *)value;
- (void)addCharacters:(NSSet *)values;
- (void)removeCharacters:(NSSet *)values;

- (void)addMoviesObject:(MovieData *)value;
- (void)removeMoviesObject:(MovieData *)value;
- (void)addMovies:(NSSet *)values;
- (void)removeMovies:(NSSet *)values;

+ (ActorData*)saveActorNamed:(NSString*) actorName PlayedCharacterNamed:(NSString*) characterName inMovie:(MovieData*) movie;

@end
