//
//  PMONSImageView.m
//  TestBirdProto
//
//  Created by Peter Molnar on 29/07/2018.
//  Copyright © 2018 Peter Molnar. All rights reserved.
//

#import "PMONSImageView.h"

@implementation PMONSImageView

#pragma mark - React to mouseDown event
- (void)mouseDown:(NSEvent *)theEvent {
    NSPoint eventLocation = [theEvent locationInWindow];
    if (self.superview) {
        eventLocation = [self convertPoint:eventLocation fromView:self.superview];
    }
    
    [self.mouseClickDelegate mouseClickedAt:CGPointMake(eventLocation.x, eventLocation.y)];
    
}

#pragma mark - Overriding the default Y corrdinate start point
- (BOOL)isFlipped {
    return YES;
}

@end
