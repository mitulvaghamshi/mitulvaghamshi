//
//  GhostProtocol.h
//
//  Created by Mitul Vaghamshi on 2022-04-17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AppProtocol <NSObject>

@required -(void)onComplete;

@end

@interface AppProtocol:NSObject {
    id <AppProtocol> _delegate;
}

@property (strong, nonatomic) id delegate;

- (void)startProcess;

@end

NS_ASSUME_NONNULL_END
