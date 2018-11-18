//
//  ViewController.m
//  HeicTest
//
//  Created by Aditya Krishnadevan on 15/11/2018.
//  Copyright © 2018 PSPDFKit GmbH. All rights reserved.
//

#import "ViewController.h"
#import "HeicTest-Swift.h"

@import MobileCoreServices;
@import AVFoundation;

#define let const __auto_type
#define var __auto_type

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    let jpeg = [self writeImageWithType:kUTTypeJPEG fileName:@"image100.jpg" quality:1.0];
//    let jpeg90 = [self writeImageWithType:kUTTypeJPEG fileName:@"image90.jpg" quality:0.9];
//    let heif = [self writeImageWithType:(__bridge CFStringRef)AVFileTypeHEIC fileName:@"image100.heic" quality:1.0];
//    let heif90 = [self writeImageWithType:(__bridge CFStringRef)AVFileTypeHEIC fileName:@"image90.heic" quality:0.9];
//
//    let fm = NSFileManager.defaultManager;
//
//    for (NSString *path in @[jpeg, jpeg90, heif, heif90]) {
//        NSLog(@"File size for %@ is %.4f.", path.lastPathComponent, ([fm attributesOfItemAtPath:path error:nil].fileSize / (1024.0 * 1024.0)));
//    }


    [self testJPEGEncodingWithQuality:1.0];
    [self testJPEGEncodingWithQuality:0.9];

    [self testHEIFEncodingWithQuality:1.0];
    [self testHEIFEncodingWithQuality:0.9];

    [self testJPEGDecodingWithQuality:1.0];
    [self testJPEGDecodingWithQuality:0.9];

    [self testHEIFDecodingWithQuality:1.0];
    [self testHEIFDecodingWithQuality:0.9];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"Performing third party benchmark...");

        [ImageCodecBenchmarker startEncodingBenchmark];
        [ImageCodecBenchmarker startDecodingBenchmark];
    });
}

- (void)testJPEGDecodingWithQuality:(CGFloat)quality {
    let jpegImagePath = [self writeImageWithType:kUTTypeJPEG fileName:@"image.jpg" quality:quality];
    let time = CACurrentMediaTime();
    for (int i = 0; i < 100; i++) {
        @autoreleasepool {
            let image = [UIImage imageWithContentsOfFile:jpegImagePath];
            UIGraphicsBeginImageContextWithOptions(image.size, NO, 1.0);
            [image drawAtPoint:CGPointZero];
            (void)UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }
    NSLog(@"Decoding JPEG %.2f took %.3fs", quality, CACurrentMediaTime() - time);
}

- (void)testHEIFDecodingWithQuality:(CGFloat)quality {
    let heicImagePath = [self writeImageWithType:(__bridge CFStringRef)AVFileTypeHEIC fileName:@"image.heic" quality:quality];
    let time = CACurrentMediaTime();
    for (int i = 0; i < 100; i++) {
        @autoreleasepool {
            let image = [UIImage imageWithContentsOfFile:heicImagePath];
            UIGraphicsBeginImageContextWithOptions(image.size, NO, 1.0);
            [image drawAtPoint:CGPointZero];
            (void)UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }
    NSLog(@"Decoding HEIC %.2f took %.3fs", quality, CACurrentMediaTime() - time);
}


- (void)testJPEGEncodingWithQuality:(CGFloat)quality {
    let image = [UIImage imageNamed:@"Star_Citizen"];

    let time = CACurrentMediaTime();
    for (int i = 0; i < 100; i++) {
        @autoreleasepool {
            let mutableImageData = [NSMutableData new];

            let destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)mutableImageData, kUTTypeJPEG, 1, NULL);
            CGImageDestinationAddImage(destination, image.CGImage, (__bridge CFDictionaryRef)@{(__bridge NSString *)kCGImageDestinationLossyCompressionQuality: @(quality)});
            CGImageDestinationFinalize(destination);
        }
    }
    NSLog(@"Encoding JPEG %.2f took %.3fs", quality, CACurrentMediaTime() - time);
}

- (void)testHEIFEncodingWithQuality:(CGFloat)quality {
    let image = [UIImage imageNamed:@"Star_Citizen"];
    let time = CACurrentMediaTime();
    for (int i = 0; i < 100; i++) {
        @autoreleasepool {
            let mutableImageData = [NSMutableData new];

            let destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)mutableImageData, (__bridge CFStringRef)AVFileTypeHEIC, 1, NULL);
            CGImageDestinationAddImage(destination, image.CGImage, (__bridge CFDictionaryRef)@{(__bridge NSString *)kCGImageDestinationLossyCompressionQuality: @(quality)});
            CGImageDestinationFinalize(destination);
        }
    }
    NSLog(@"Encoding HEIC %.2f took %.3fs", quality, CACurrentMediaTime() - time);
}

- (NSString *)writeImageWithType:(CFStringRef)type fileName:(NSString *)fileName quality:(CGFloat)quality {
    let image = [UIImage imageNamed:@"Star_Citizen"];

    let mutableImageData = [NSMutableData new];

    let destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)mutableImageData, type, 1, NULL);
    CGImageDestinationAddImage(destination, image.CGImage, (__bridge CFDictionaryRef)@{(__bridge NSString *)kCGImageDestinationLossyCompressionQuality: @(quality)});
    CGImageDestinationFinalize(destination);

    let docsDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    let path = [docsDir stringByAppendingPathComponent:fileName];
    [mutableImageData writeToFile:path atomically:NO];

    return path;
}


@end
