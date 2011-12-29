//
//  ActorData.m
//  NerderyCodeChallenge
//
//  Created by Sergey Klimov on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ActorData.h"
#import "MovieData.h"
#import "CharacterData.h"


@implementation ActorData

@dynamic name;
@dynamic characters;
@dynamic movies;
+ (ActorData*)saveActorNamed:(NSString*) actorName PlayedCharacterNamed:(NSString*) characterName inMovie:(MovieData*) movie {
    ActorData* actor = [self MR_findFirstByAttribute:@"name" withValue:actorName];
    if (!actor) {
        actor = [self MR_createEntity];
        actor.name = actorName;
    }
    
    [actor addMoviesObject:movie];
    [actor addCharactersObject:
        [CharacterData saveCharacterNamed:characterName playedByActor: actor inMovie: movie]];
    return actor;
}
@end
