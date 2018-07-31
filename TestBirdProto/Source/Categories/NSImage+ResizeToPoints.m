//
//  NSImage+ResizeToPoints.m
//  TestBirdProto
//
//  Created by Peter Molnar on 31/07/2018.
//  Copyright © 2018 Peter Molnar. All rights reserved.
//

#import "NSImage+ResizeToPoints.h"
#import "NSImage+Resize.h"

@implementation NSImage (ResizeToPoints)


/**
 DescriptionResizing the receiving image according to the rendered size of the iPhone.
 See https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions for the details
 
 @param anImage screenshot from an iPhone, with the rendere pixel size
 @return point based representation of the screenshot
 */
+ (NSImage *)imageResizeToPoints:(NSImage*)anImage {
    
    NSImage *resultImage;
    
    switch ((int)anImage.size.width) {
            // 5s portrait
        case 640:
            resultImage = [NSImage imageResize:anImage newSize:NSMakeSize(320, 568)];
            break;
            //5s landscape
        case 1136:
            resultImage = [NSImage imageResize:anImage newSize:NSMakeSize(568, 320)];
            break;
            // 6-8 portrait
        case 750:
            resultImage = [NSImage imageResize:anImage newSize:NSMakeSize(375, 667)];
            break;
            //6-8 landscape
        case 1334:
            resultImage = [NSImage imageResize:anImage newSize:NSMakeSize(667, 375)];
            break;
            // 6+-8+ portrait
        case 1242:
            resultImage = [NSImage imageResize:anImage newSize:NSMakeSize(414, 736)];
            break;
            //6+-8+ landscape
        case 2208:
            resultImage = [NSImage imageResize:anImage newSize:NSMakeSize(736, 414)];
            break;
        //X portait
        case 1125:
            resultImage = [NSImage imageResize:anImage newSize:NSMakeSize(375, 815)];
            break;
            //X landscape
        case 2436:
            resultImage = [NSImage imageResize:anImage newSize:NSMakeSize(815, 375)];
            break;
            
        default:
            break;
    }
    
    return resultImage;
    
}

@end
