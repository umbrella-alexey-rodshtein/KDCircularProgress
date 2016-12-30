//
//  Math.swift
//  Pods
//
//  Created by Alexey Rodshtein on 29.12.16.
//  Copyright © 2016 Kaan Dedeoglu. All rights reserved.
//

import Foundation
import UIKit

internal class Math {
    
    internal class func degreesToRadians(angle: Double) -> Double {
        return angle / 180 * M_PI
    }
    
    internal class func pointFromAngle(frame: CGRect, angle: Double, radius: Double) -> CGPoint {
        let radian = self.degreesToRadians(angle: angle)
        let x = Double(frame.midX) + cos(radian) * radius
        let y = Double(frame.midY) + sin(radian) * radius
        return CGPoint(x: x, y: y)
    }
    
    internal class func pointPairToBearingDegrees(startPoint: CGPoint, endPoint: CGPoint) -> Double {
        let originPoint = CGPoint.init(x: endPoint.x - startPoint.x, y: endPoint.y - startPoint.y)
        let bearingRadians = atan2(Double(originPoint.y), Double(originPoint.x))
        var bearingDegrees = bearingRadians * (180.0 / M_PI)
        bearingDegrees = (bearingDegrees > 0.0 ? bearingDegrees : (360.0 + bearingDegrees))
        return bearingDegrees
    }
    
    internal class func adjustValue(startAngle: Double, degree: Double, maxValue: Float, minValue: Float) -> Double {
        let ratio = Double((maxValue - minValue) / 360)
        let ratioStart = ratio * startAngle
        let ratioDegree = ratio * degree
        let adjustValue: Double
        if startAngle < 0 {
            adjustValue = (360 + startAngle) > degree ? (ratioDegree - ratioStart) : (ratioDegree - ratioStart) - (360 * ratio)
        } else {
            adjustValue = (360 - (360 - startAngle)) < degree ? (ratioDegree - ratioStart) : (ratioDegree - ratioStart) + (360 * ratio)
        }
        return adjustValue + (Double(minValue))
    }
    
    internal class func adjustDegree(startAngle: Double, degree: Double) -> Double {
        return (360 + startAngle) > degree ? degree : -(360 - degree)
    }
    
    internal class func degreeFromValue(startAngle: Double, value: Float, maxValue: Float, minValue: Float) -> Double {
        let ratio = Double((maxValue - minValue) / 360)
        let angle = Double(value) / ratio
        return angle + startAngle - (Double(minValue) / ratio)
    }
}

