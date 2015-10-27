//
//  MemoryGameKitTests.m
//  MemoryGameKitTests
//
//  Created by         on 24/10/15.
//  Copyright © 2015  . All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import "GameController.h"
#import "Game.h"
#import "Track.h"

@interface GameController()
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSMutableDictionary *matchesDict;
@property (nonatomic, strong) Game *currentGame;
@end

@interface GameControllerDelegateMock : NSObject <GameControllerDelegate>
@property (nonatomic) BOOL didFailCalled;
@property (nonatomic) BOOL didFoundCalled;
@property (nonatomic) BOOL didFinishCalled;
@end
@implementation GameControllerDelegateMock
- (void)didFailToFindMatchAtIndex:(NSInteger)firstIndex and:(NSInteger)secondIndex { self.didFailCalled = YES; }
- (void)didFoundMatchAtIndex:(NSInteger)firstIndex and:(NSInteger)secondIndex { self.didFoundCalled = YES; }
- (void)didFinishGame { self.didFinishCalled = YES; }
@end

SpecBegin(GameController)


GameController* (^getController)() = ^GameController*() {
    GameController *gameController = [GameController new];
    NSMutableArray *tracksArray = [NSMutableArray new];
    for (int i=0; i<8; i++) {
        Track *newTrack = [Track trackWithDictionary:@{@"id":@(i)}];
        [tracksArray addObject:newTrack];
    }
    gameController.currentGame = [Game gameWithItems:tracksArray];
    gameController.selectedIndex = -1;
    return gameController;
};


describe(@"GameController", ^{
    
    describe(@"canSelectItemAtIndex", ^{
        context(@"The item is not matchet yet", ^{
            __block BOOL canBeSelected;
            beforeEach(^{
                canBeSelected = [getController() canSelectItemAtIndex:0];
            });
            it(@"can be selected", ^{
                expect(canBeSelected).to.beTruthy();
            });
        });
        
        context(@"the item has been matched", ^{
            __block BOOL canBeSelected;
            beforeEach(^{
                GameController *controller = getController();
                [controller.matchesDict setObject:@1 forKey:@(0)];
                canBeSelected = [controller canSelectItemAtIndex:0];
            });
            it(@"can be selected", ^{
                expect(canBeSelected).to.beFalsy();
            });
        });
    });
    
    describe(@"selectItemAtIndex", ^{
        __block GameController *controller;
        __block GameControllerDelegateMock *delegate;
        beforeEach(^{
            controller = getController();
            delegate = [GameControllerDelegateMock new];
            controller.delegate = delegate;
        });
        context(@"Is the first item to be selected", ^{
            beforeEach(^{
                [controller selectItemAtIndex:2];
            });
            it(@"stores correctly the selected index", ^{
                expect(controller.selectedIndex).to.equal(2);
            });
        });
        
        context(@"is the second item to be selected and there is a match", ^{
            beforeEach(^{
                // test case with two items with the same ID, forcing a match at indexes 0 and 1.
                Track *oneTrack = [Track trackWithDictionary:@{@"id":@(123)}];
                Track *anotherTrack = [Track trackWithDictionary:@{@"id":@(2345)}];

                controller.currentGame.items = @[oneTrack, oneTrack, anotherTrack, anotherTrack],
                controller.selectedIndex = 0;
                [controller selectItemAtIndex:1];
            });
            it(@"resets the selectedIndex to -1", ^{
                expect(controller.selectedIndex).to.equal(-1);
            });
            it(@"adds the first match index to the matches dictionary", ^{
                expect([controller.matchesDict objectForKey:@(0)]).toNot.beNil();
            });
            it(@"adds the second match index to the matches dictionary", ^{
                expect([controller.matchesDict objectForKey:@(1)]).toNot.beNil();
            });
            it(@"calls the correct delegate method", ^{
                expect(delegate.didFoundCalled).to.beTruthy();
            });
        });
        
        context(@"is the second item to be selected but there is no match", ^{
            beforeEach(^{
                // test case with two items with the same ID, forcing a no-match at indexes 0 and 1.
                Track *oneTrack = [Track trackWithDictionary:@{@"id":@(123)}];
                Track *anotherTrack = [Track trackWithDictionary:@{@"id":@(2345)}];
                
                controller.currentGame.items = @[oneTrack, anotherTrack, oneTrack, anotherTrack],
                controller.selectedIndex = 0;
                [controller selectItemAtIndex:1];
            });
            it(@"resets the selectedIndex to -1", ^{
                expect(controller.selectedIndex).to.equal(-1);
            });
            it(@"doesn't add the first match index to the matches dictionary", ^{
                expect([controller.matchesDict objectForKey:@(0)]).to.beNil();
            });
            it(@"doesn't add the second match index to the matches dictionary", ^{
                expect([controller.matchesDict objectForKey:@(1)]).to.beNil();
            });
            it(@"calls the correct delegate method", ^{
                expect(delegate.didFailCalled).to.beTruthy();
            });
        });
        
        context(@"is the second item to be selected, there is a match and is the last one", ^{
            beforeEach(^{
                // test case with two items with the same ID, forcing a no-match at indexes 0 and 1.
                Track *oneTrack = [Track trackWithDictionary:@{@"id":@(123)}];
                
                controller.currentGame.items = @[oneTrack, oneTrack],
                controller.selectedIndex = 0;
                [controller selectItemAtIndex:1];
            });
            it(@"calls the correct delegate method", ^{
                expect(delegate.didFinishCalled).to.beTruthy();
            });
        });
    });
    
    describe(@"restart", ^{
        __block GameController *controller;
        beforeEach(^{
            controller = getController();
        });
        context(@"", ^{
            it(@"selected index is reseted", ^{
                expect(controller.selectedIndex).to.equal(-1);
            });
            it(@"the matches dictionary is empty", ^{
                expect(controller.matchesDict.allKeys.count).to.equal(0);
            });
        });
    });
    
});

SpecEnd

