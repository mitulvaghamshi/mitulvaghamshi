//
//  DBManager.m
//
//  Created by Mitul Vaghamshi on 2022-04-17.
//

#import "DBManager.h"

static DBManager *instance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager

+(DBManager*)getSharedInstance {
    if (!instance) {
        instance = [[super allocWithZone:NULL]init];
        [instance onCreate];
    }
    return instance;
}

-(BOOL)onCreate {
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = dirPaths[0];
    databasePath = [[NSString alloc]initWithString:[docsDir stringByAppendingPathComponent:@"Contacts.s3db"]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isSuccess = YES;
    if ([fileManager fileExistsAtPath:databasePath] == NO) {
        const char *dbPath = [databasePath UTF8String];
        if (sqlite3_open(dbPath, &database) == SQLITE_OK) {
            char *errorMsg;
            const char *sql = "CREATE TABLE IF NOT EXISTS ContactsTable(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phone TEXT);";
            if (sqlite3_exec(database, sql, NULL, NULL, &errorMsg) != SQLITE_OK) {
                isSuccess = NO;
                NSLog(@"Failed to create table. Cause: %s", errorMsg);
            }
            sqlite3_close(database);
            return isSuccess;
        } else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database.");
        }
    }
    return isSuccess;
}

-(BOOL)saveContactWithName:(NSString *)name andNumber:(NSString *)phone {
    const char *dbPath = [databasePath UTF8String];
    if (sqlite3_open(dbPath, &database) == SQLITE_OK) {
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO ContactsTable VALUES(NULL,\"%@\",\"%@\");", name, phone];
        const char *stmt = [sql UTF8String];
        sqlite3_prepare_v2(database, stmt, -1, &statement, NULL);
        BOOL isSuccess = sqlite3_step(statement) == SQLITE_DONE;
        sqlite3_reset(statement);
        return isSuccess;
    } else {
        NSLog(@"Failed to open/create database.");
    }
    return NO;
}

-(NSDictionary*)findByName:(NSString *)name {
    const char *dbPath = [databasePath UTF8String];
    if (sqlite3_open(dbPath, &database) == SQLITE_OK) {
        NSString *sql = [NSString stringWithFormat:@"SELECT id, name, phone FROM ContactsTable WHERE name LIKE \"\%%%@\%%\";", name];
        const char *stmt = [sql UTF8String];
        NSMutableDictionary *contactsDict = [[NSMutableDictionary alloc]init];
        if (sqlite3_prepare_v2(database, stmt, -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                NSInteger _id = sqlite3_column_int(statement, 0);
                NSString *name = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *phone = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                [contactsDict setObject:[[NSArray alloc] initWithObjects: [[NSString alloc] initWithFormat:@"%ld", (long)_id], name, phone, nil] forKey:@"SearchResult"];
                sqlite3_reset(statement);
                return contactsDict;
            } else {
                NSLog(@"No result found.");
                return nil;
            }
        }
    } else {
        NSLog(@"Failed to open/create database.");
    }
    return nil;
}

@end
