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
    
    [capabilities setValue:@"iOS" forKey:@"platformName"];
    [capabilities setValue:[self.platFormVersionTxt stringValue]  forKey:@"platformVersion"];
    [capabilities setValue:[self.deviceNameTxt stringValue] forKey:@"deviceName"];
    [capabilities setValue:[self.automatinoNameTxt stringValue] forKey:@"automationName"];
    [capabilities setValue:[[self.appTxt stringValue] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"app"];
    [capabilities setValue:[self.xcodeOrdIdTxt stringValue] forKey:@"xcodeOrgId"];
    [capabilities setValue:[self.udidTxt stringValue] forKey:@"udid"];
    [capabilities setValue:[self.xcodeSigningIdTxt stringValue] forKey:@"xcodeSigningId"];
    if ([self.noReset state] == NSOnState ) {
        [capabilities setValue:@"true" forKey:@"noReset"];
    } else {
        [capabilities setValue:@"false" forKey:@"noReset"];
    }
    
    return capabilities;
}

#pragma mark - IB Action implementations
- (IBAction)initAppiumSession:(NSButton *)sender {
    
    [self initMainSession];
}

- (IBAction)makeScreenShot:(NSButtonCell *)sender {
    NSError *error;
    if (!self.mainSession) {
        [self initMainSession];
    }
    
    NSImage *screenShot = [self.mainAppiumClient getScreenshotWithSession:self.mainSession.sessionId error:&error];
    
    if (screenShot) {
        // Using an extension to resize according to the points of the iOS device (iPhone)
        screenShot = [NSImage imageResizeToPoints:screenShot];
        self.imageView.image = screenShot;
        
        [self.imageView setFrameSize:screenShot.size];
        [self.imageView setFrame:NSMakeRect(0, self.view.frame.size.height - screenShot.size.height, screenShot.size.width, screenShot.size.height)];
        [self.imageView setNeedsDisplay];
        
    }
}


#pragma mark - Accessors
- (SEJsonWireClient *)mainAppiumClient {
    if (!_mainAppiumClient) {
        _mainAppiumClient = [PMOAppiumClientFactory buildClientForServerAddress:@"0.0.0.0" serverPort:4723];
    }
    return _mainAppiumClient;
}

#pragma mark - Implementing PMOMouseClickedDelegate
- (void)mouseClickedAt:(NSPoint)location {
    
    NSError *error;
    
    SETouchAction *newTouchAction = [[SETouchAction alloc] init];
    [newTouchAction tapAtX:location.x y:location.y];
    
    [self.mainAppiumClient postTouchAction:newTouchAction session:self.mainSession.sessionId error:&error];
    
}

#pragma mark - Helpers
- (void)initMainSession {
    NSError *error;
    
    self.mainSession = [self.mainAppiumClient postSessionWithDesiredCapabilities:[PMOAppiumClientFactory buildCapabilitiesFrom:[self capabilitiesFromUI]] andRequiredCapabilities:nil error:&error];
}

@end
