//
//  NSImage+ResizeToPoints.h
//  TestBirdProto
//
//  Created by Peter Molnar on 31/07/2018.
//  Copyright © 2018 Peter Molnar. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (ResizeToPoints)

+ (NSImage *)imageResizeToPoints:(NSImage*)anImage;

@end
