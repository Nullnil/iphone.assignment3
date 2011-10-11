//
//  FileManager.m
//  SmartCamera
//
//  Created by sen hou on 12/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (void) writeToFile:(User *)user withFileName:(NSString *)fileName{
    
    NSString* docs;
    NSFileManager* fm;
    NSString* myfolder;
    NSString* moifile;
    
    docs = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    fm = [[NSFileManager alloc] init];
    NSError* err = nil;
    
    if (err){
        NSLog(@"%@", err.description);
    }
    
    myfolder = [docs stringByAppendingPathComponent:@"UserInfo"];
    BOOL exists = [fm fileExistsAtPath:myfolder];
    if (!exists) {
        NSError* err = nil;
        [fm createDirectoryAtPath:myfolder withIntermediateDirectories:NO attributes:nil error:&err];
    }
    
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:user]; 
    moifile = [myfolder stringByAppendingPathComponent:fileName]; 
    [data writeToFile:moifile atomically:NO];
}

+(User *) readFromFile:(NSString *)fileName{
    NSString* docs;
    NSFileManager* fm;
    NSString* myfolder;
    NSString* moifile;
    
    docs = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    fm = [[NSFileManager alloc] init];
    NSError* err = nil;
    
    if (err){
        NSLog(@"%@", err.description);
    }
    
    myfolder = [docs stringByAppendingPathComponent:@"UserInfo"];
    BOOL exists = [fm fileExistsAtPath:myfolder];
    if (!exists) {
        NSError* err = nil;
        [fm createDirectoryAtPath:myfolder withIntermediateDirectories:NO attributes:nil error:&err];
    }

    moifile = [myfolder stringByAppendingPathComponent:fileName]; 
    NSData* persondata = [[NSData alloc] initWithContentsOfFile:moifile]; 
    User* user = [NSKeyedUnarchiver unarchiveObjectWithData:persondata]; 
    [persondata release];
    
    return  user;
}

+ (BOOL) isFileExist{
    
    NSString* docs;
    NSFileManager* fm;
    NSString* myfolder;
    
    docs = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    fm = [[NSFileManager alloc] init];
    myfolder = [docs stringByAppendingPathComponent:@"UserInfo"];
    BOOL exists = [fm fileExistsAtPath:myfolder];
    if (!exists) {
        return NO;
    }else{
        return YES;
    }
}

@end
