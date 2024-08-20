//
//  GhostProtocol.m
//
//  Created by Mitul Vaghamshi on 2022-04-17.
//

#import <Foundation/Foundation.h>
#import "AppProtocol.h"

@implementation AppProtocol

- (void)startProcess {
    [NSTimer
     scheduledTimerWithTimeInterval:5.0
     target:self.delegate
     selector:@selector(onComplete)
     userInfo:nil
     repeats:NO];
}

@end
