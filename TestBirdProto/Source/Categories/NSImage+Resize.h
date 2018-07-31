//
//  NSImage+Resize.h
//  TestBirdProto
//
//  Created by Peter Molnar on 30/07/2018.
//  Copyright © 2018 Peter Molnar. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (Resize)

+ (NSImage *)imageResize:(NSImage*)anImage newSize:(NSSize)newSize;

@end
