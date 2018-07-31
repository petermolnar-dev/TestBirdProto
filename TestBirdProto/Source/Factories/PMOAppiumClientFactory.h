//
//  PMOAppiumClientFactory.h
//  TestBirdProto
//
//  Created by Peter Molnar on 31/07/2018.
//  Copyright © 2018 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Selenium.h>

@interface PMOAppiumClientFactory : NSObject

+ (nullable SEJsonWireClient *)buildClientForServerAddress:(nonnull NSString *)serverAddress serverPort:(NSInteger)serverPort;

+ (nonnull SECapabilities *)buildCapabilitiesFrom:(nullable NSDictionary *)desiredCapabilities;

@end
