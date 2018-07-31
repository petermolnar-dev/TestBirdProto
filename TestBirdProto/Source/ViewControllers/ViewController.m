//
//  ViewController.m
//  TestBirdProto
//
//  Created by Peter Molnar on 24/07/2018.
//  Copyright © 2018 Peter Molnar. All rights reserved.
//

#import "ViewController.h"
#import <Selenium.h>
#import "PMOAppiumClientFactory.h"
#import "NSImage+ResizeToPoints.h"


@interface ViewController()

@property (weak) IBOutlet PMONSImageView *imageView;

// Outlets for the view
@property (weak) IBOutlet NSTextField *platFormVersionTxt;
@property (weak) IBOutlet NSTextField *deviceNameTxt;
@property (weak) IBOutlet NSTextField *automatinoNameTxt;
@property (weak) IBOutlet NSTextField *appTxt;
@property (weak) IBOutlet NSTextField *xcodeOrdIdTxt;
@property (weak) IBOutlet NSTextField *udidTxt;
@property (weak) IBOutlet NSTextField *xcodeSigningIdTxt;
@property (weak) IBOutlet NSButton *noReset;

@property (strong, nonatomic, nullable) SEJsonWireClient *mainAppiumClient;
@property (strong, nonatomic, nullable) SESession *mainSession;
@end

@implementation ViewController

#pragma mark - ViewController lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.mouseClickDelegate = self;
}

#pragma mark - Build capabilities from the UI
- (NSDictionary *)capabilitiesFromUI {
    NSMutableDictionary *capabilities = [[NSMutableDictionary alloc] init];
    
    [capabilities insertValue:[self.platFormVersionTxt stringValue] inPropertyWithKey:@"platformVersion"];
    [capabilities insertValue:[self.deviceNameTxt stringValue] inPropertyWithKey:@"deviceName"];
    [capabilities insertValue:[self.automatinoNameTxt stringValue] inPropertyWithKey:@"automationName"];
    [capabilities insertValue:[self.appTxt stringValue] inPropertyWithKey:@"app"];
    [capabilities insertValue:[self.xcodeOrdIdTxt stringValue] inPropertyWithKey:@"xcodeOrgId"];
    [capabilities insertValue:[self.udidTxt stringValue] inPropertyWithKey:@"udid"];
    [capabilities insertValue:[self.xcodeSigningIdTxt stringValue] inPropertyWithKey:@"xcodeSigningId"];
    if ([self.noReset state] == NSOnState ) {
        [capabilities insertValue:@"true" inPropertyWithKey:@"noReset"];
    } else {
        [capabilities insertValue:@"false" inPropertyWithKey:@"noReset"];
    }
    
    return capabilities;
}

#pragma mark - IB Action implementations
- (IBAction)initAppiumSession:(NSButton *)sender {
    
    NSError *error;
    
    self.mainSession = [self.mainAppiumClient postSessionWithDesiredCapabilities:[PMOAppiumClientFactory buildCapabilitiesFrom:[self capabilitiesFromUI]] andRequiredCapabilities:nil error:&error];
}

- (IBAction)makeScreenShot:(NSButtonCell *)sender {
    NSError *error;
    NSImage *screenShot = [self.mainAppiumClient getScreenshotWithSession:self.mainSession.sessionId error:&error];
    
    if (screenShot) {
        // Using an extension to resize according to the points of the iOS device (iPhone)
        screenShot = [NSImage imageResizeToPoints:screenShot];
        self.imageView.image = screenShot;
        
        [self.imageView setFrameSize:screenShot.size];
        [self.imageView setNeedsDisplay];
        
    }
}


#pragma mark - Accessors
- (SEJsonWireClient *)mainAppiumClient {
    return [PMOAppiumClientFactory buildClientForServerAddress:@"0.0.0.0" serverPort:4723];
}

#pragma mark - Implementing PMOMouseClickedDelegate
- (void)mouseClickedAt:(NSPoint)location {
    
    NSError *error;
    
    SETouchAction *newTouchAction = [[SETouchAction alloc] init];
    [newTouchAction tapAtX:location.x y:location.y];
    
    [self.mainAppiumClient postTouchAction:newTouchAction session:self.mainSession.sessionId error:&error];
    
}

@end
