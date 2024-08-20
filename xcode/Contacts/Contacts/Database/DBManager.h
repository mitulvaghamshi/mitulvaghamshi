//
//  DBManager.h
//
//  Created by Mitul Vaghamshi on 2022-04-17.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBManager:NSObject {
    NSString*databasePath;
}

+(DBManager*)getSharedInstance;
-(BOOL)onCreate;
-(BOOL)saveContactWithName:(NSString*)name andNumber:(NSString*)phone;
-(NSDictionary*)findByName:(NSString*)name;

@end

NS_ASSUME_NONNULL_END
