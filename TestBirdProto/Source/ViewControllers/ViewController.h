//
//  ViewController.h
//  TestBirdProto
//
//  Created by Peter Molnar on 24/07/2018.
//  Copyright © 2018 Peter Molnar. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PMONSImageView.h"

@interface ViewController : NSViewController <PMOMouseClickedDelegate>


@property (weak) IBOutlet PMONSImageView *imageView;

@end

