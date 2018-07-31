//
//  mouseClickedDelegate.h
//  TestBirdProto
//
//  Created by Peter Molnar on 29/07/2018.
//  Copyright © 2018 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PMOMouseClickedDelegate <NSObject>

- (void) mouseClickedAt:(NSPoint) location;

@end
