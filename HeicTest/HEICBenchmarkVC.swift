//
//  HEICBenchmarkVC.swift
//  HeicTest
//
//  Created by Peter Steinberger on 15.11.18.
//  Copyright © 2018 PSPDFKit GmbH. All rights reserved.
//

import Foundation

import UIKit
import AVFoundation

extension Data {
    static func UImageHEICRepr(image: UIImage, quality: CGFloat) -> Data {
        let imageData = NSMutableData()
        if let destination = CGImageDestinationCreateWithData(imageData as CFMutableData, AVFileType.heic as CFString, 1, nil) {
            let options = [kCGImageDestinationLossyCompressionQuality:quality]
            CGImageDestinationAddImage(destination, image.cgImage!, options as CFDictionary)
            CGImageDestinationFinalize(destination)
        }
        return imageData as Data
    }

    static func UImageJPEGRepr(image: UIImage, quality: CGFloat) -> Data {
        let imageData = NSMutableData()
        if let destination = CGImageDestinationCreateWithData(imageData as CFMutableData, AVFileType.jpg as CFString, 1, nil) {
            let options = [kCGImageDestinationLossyCompressionQuality:quality]
            CGImageDestinationAddImage(destination, image.cgImage!, options as CFDictionary)
            CGImageDestinationFinalize(destination)
        }
        return imageData as Data
    }
}

class ImageCodecBenchmarker: NSObject {

    private class func measureAndLogTimeToRunBlockNamed(_ title: String, iterations: Int = 100, operation: () -> ()) {
        let startTime = CFAbsoluteTimeGetCurrent()
        for _ in 0 ..< iterations {
            autoreleasepool {
                operation()
            }

        }
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime

        NSLog("\(title) took %.3f seconds to complete.", timeElapsed)
    }

   @objc class func startEncodingBenchmark() {
        let anImage = UIImage(named: "Star_Citizen")!

        measureAndLogTimeToRunBlockNamed("Encoding HEIC 1.0") {
            let _ = Data.UImageHEICRepr(image: anImage, quality: 1.0)
        }

        measureAndLogTimeToRunBlockNamed("Encoding HEIC 0.9") {
            let _ = Data.UImageHEICRepr(image: anImage, quality: 0.9)
        }

        measureAndLogTimeToRunBlockNamed("Encoding JPEG 1.0") {
            let _ = Data.UImageJPEGRepr(image: anImage, quality: 1.0)
        }

        measureAndLogTimeToRunBlockNamed("Encoding JPEG 0.9") {
            let _ = Data.UImageJPEGRepr(image: anImage, quality: 0.9)
        }
    }

    @objc class func startDecodingBenchmark() {

        let anImage = UIImage(named: "Star_Citizen")!
        let heicImage = Data.UImageHEICRepr(image: anImage, quality: 1.0)
        measureAndLogTimeToRunBlockNamed("Decoding HEIC 1.0") {
            let decodedImage = UIImage(data: heicImage)!
            UIGraphicsBeginImageContextWithOptions(decodedImage.size, false, 1.0)
            decodedImage.draw(at: CGPoint.zero)
            UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }

        let jpgImage = Data.UImageJPEGRepr(image: anImage, quality: 1.0)
        measureAndLogTimeToRunBlockNamed("Decoding JPEG 1.0") {
            let decodedImage = UIImage(data: jpgImage)!
            UIGraphicsBeginImageContextWithOptions(decodedImage.size, false, 1.0)
            decodedImage.draw(at: CGPoint.zero)
            UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }

        let heicImage90 = Data.UImageHEICRepr(image: anImage, quality: 0.9)
        measureAndLogTimeToRunBlockNamed("Decoding HEIC 0.9") {
            let decodedImage = UIImage(data: heicImage90)!
            UIGraphicsBeginImageContextWithOptions(decodedImage.size, false, 1.0)
            decodedImage.draw(at: CGPoint.zero)
            UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }

        let jpgImage90 = Data.UImageJPEGRepr(image: anImage, quality: 0.9)
        measureAndLogTimeToRunBlockNamed("Decoding JPEG 0.9") {
            let decodedImage = UIImage(data: jpgImage90)!
            UIGraphicsBeginImageContextWithOptions(decodedImage.size, false, 1.0)
            decodedImage.draw(at: CGPoint.zero)
            UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
    }
}
