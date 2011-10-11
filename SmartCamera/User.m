//
//  User.m
//  SmartCamera
//
//  Created by sen hou on 12/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize userName;
@synthesize password;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id) initWithUserName:(NSString *)name andPassword:(NSString *)pass{
    self = [super init];
    if (self) {
        [self setUserName:name];
        [self setPassword:pass];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[self userName] forKey:@"userName"]; 
    [encoder encodeObject:[self password] forKey:@"password"];
}

- (id) initWithCoder:(NSCoder *)decoder {
    self = [super init];
    self.userName = [decoder decodeObjectForKey:@"userName"]; 
    [[self userName] retain];
    self.password = [decoder decodeObjectForKey:@"password"];
    [self.password retain];
    return self; 
}

- (void) dealloc{
    [super dealloc];
    [userName release];
    [password release];
}

@end
