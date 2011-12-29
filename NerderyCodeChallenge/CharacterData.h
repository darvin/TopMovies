//
//  CharacterData.h
//  NerderyCodeChallenge
//
//  Created by Sergey Klimov on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ActorData, MovieData;

@interface CharacterData : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) ActorData *actor;
@property (nonatomic, retain) MovieData *movie;

+(CharacterData*)saveCharacterNamed:(NSString*)characterName playedByActor:(ActorData*) actor inMovie:(MovieData*) movie;

@end
