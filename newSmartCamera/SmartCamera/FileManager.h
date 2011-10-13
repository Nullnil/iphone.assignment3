//
//  FileManager.h
//  SmartCamera
//
//  Created by sen hou on 12/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface FileManager : NSObject


+ (void) writeToFile:(User *)user withFileName:(NSString *)fileName;

+(User *) readFromFile:(NSString *)fileName;

+ (BOOL) isFileExist;
@end
