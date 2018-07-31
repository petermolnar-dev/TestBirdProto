//
//  ViewController.m
//  TestBirdProto
//
//  Created by Peter Molnar on 24/07/2018.
//  Copyright © 2018 Peter Molnar. All rights reserved.
//

#import "ViewController.h"
#import <Selenium.h>
#import "NSImage+Resize.h"



@interface ViewController()

@property (strong, nonatomic, nullable) SEJsonWireClient *mainSeleniumController;
@property (strong, nonatomic, nullable) SESession *mainSession;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.mouseClickDelegate = self;
}

#pragma mark - IB Action implementations
- (IBAction)buttonPressed:(NSButton *)sender {
    NSError *error;
    //TODO: server address and port should be parameter form UI
    self.mainSeleniumController = [[SEJsonWireClient alloc] initWithServerAddress:@"0.0.0.0" port:4723 error:&error];
    //TODO: Capability list should be a parameter from UI.
    if ([error.localizedDescription isEqualToString:@"Success: The command executed successfully."]) {
        NSDictionary *capabilities = @{
                                       @"platformName": @"iOS",
                                       @"platformVersion": @"11.4",
                                       @"deviceName": @"Peter Molnar's iPhone",
                                       @"automationName": @"XCUITest",
                                       @"app": @"/Users/peti/Quiz/Quiz.ipa"                                       };
        SECapabilities *iOSCapabilities = [[SECapabilities alloc] initWithDictionary:capabilities];
        [iOSCapabilities addCapabilityForKey: @"noReset" andValue:@"true"];
        [iOSCapabilities addCapabilityForKey:@"xcodeOrgId" andValue:@"3YBS3Y2WC7"];
        [iOSCapabilities addCapabilityForKey:@"udid" andValue:@"aea8d5b777ad201f28f6d0f5b678e9ece13ea6d1"];
        [iOSCapabilities addCapabilityForKey:@"xcodeSigningId" andValue:@"Peter Molnar"];
        
        
        self.mainSession = [self.mainSeleniumController postSessionWithDesiredCapabilities:iOSCapabilities andRequiredCapabilities:nil error:&error];
        
    }
}

- (IBAction)makeScreenShot:(NSButtonCell *)sender {
    NSError *error;
    NSImage *screenShot = [self.mainSeleniumController getScreenshotWithSession:self.mainSession.sessionId error:&error];
    if (screenShot) {
#warning Implement for the different screenSizes
        screenShot = [NSImage imageResize:screenShot newSize:NSMakeSize(375, 667)];
        
        self.imageView.image = screenShot;
        
        [self.imageView setFrameSize:screenShot.size];
        [self.imageView setNeedsDisplay];
        NSLog(@"Image size, width: %f, heght: %f", screenShot.size.width, screenShot.size.height);
        
        NSLog(@"ImageView frame sizes: width: %f, height: %f", self.imageView.frame.size.width, self.imageView.frame.size.height);
        
    }
}

#pragma mark - Implementing PMOMouseClickedDelegate
- (void)mouseClickedAt:(NSPoint)location {
    NSError *error;
    SETouchAction *newTouchAction = [[SETouchAction alloc] init];
    [newTouchAction tapAtX:location.x y:location.y];
    [self.mainSeleniumController postTouchAction:newTouchAction session:self.mainSession.sessionId error:&error];
    
}

@end
