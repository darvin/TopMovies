//
//  CharacterData.m
//  NerderyCodeChallenge
//
//  Created by Sergey Klimov on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CharacterData.h"
#import "ActorData.h"
#import "MovieData.h"


@implementation CharacterData

@dynamic name;
@dynamic actor;
@dynamic movie;
+(CharacterData*)saveCharacterNamed:(NSString*)characterName playedByActor:(ActorData*) actor inMovie:(MovieData*) movie {
    CharacterData *character = [self MR_createEntity];
    character.name = characterName;
    character.movie = movie;
    character.actor = actor;
    return character;
}
@end
