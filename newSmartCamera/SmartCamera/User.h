//
//  User.h
//  SmartCamera
//
//  Created by sen hou on 12/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject  <NSCoding>{
    NSString *userName;
    NSString *password;
}

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;


- (id) initWithUserName:(NSString *)name andPassword:(NSString *)pass;

- (void)encodeWithCoder:(NSCoder *)encoder ;
- (id) initWithCoder:(NSCoder *)decoder;

@end
