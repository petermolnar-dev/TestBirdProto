//
//  PMONSImageView.h
//  TestBirdProto
//
//  Created by Peter Molnar on 29/07/2018.
//  Copyright © 2018 Peter Molnar. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PMOMouseClickedDelegate.h"

@interface PMONSImageView : NSImageView

@property (weak, nonatomic, nullable) id <PMOMouseClickedDelegate> mouseClickDelegate;


@end

