//
//  UIImage+Extension.swift
//  HHUIKit
//
//  Created by master on 2020/1/2.
//  Copyright © 2020 com.ian.Test. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage{
    
    
    
    ///从颜色创建图片
    static func from(_ color:UIColor)->UIImage{
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    

    ///改变图片的颜色
    func changeColor(_ color:UIColor)->UIImage{
        UIGraphicsBeginImageContext(self.size)
        color.setFill()
        let bounds = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
    
    
    /// 获取网络图片尺寸
     ///
     /// - Parameter url: 网络图片链接
     /// - Returns: 图片尺寸size
     class func getImageSize(_ url: String?) -> CGSize {
         
         guard let urlStr = url else {
             return CGSize.zero
         }
         let tempUrl = URL(string: urlStr)
         let imageSourceRef = CGImageSourceCreateWithURL(tempUrl! as CFURL, nil)
         
         var width: CGFloat = 0
         var height: CGFloat = 0

         if let imageSRef = imageSourceRef {
             let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSRef, 0, nil)
             if let imageP = imageProperties {
                 let imageDict = imageP as Dictionary
                 width = imageDict[kCGImagePropertyPixelWidth] as! CGFloat
                 height = imageDict[kCGImagePropertyPixelHeight] as! CGFloat
             }
         }
         return CGSize(width: width, height: height)
     }
    
    
    
     /*1.识别图片二维码
     
     - returns: 二维码内容
     */
    ///识别途中的二维码
    func recognizeQRCode() -> String?
    {
            
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy : CIDetectorAccuracyHigh])
        let features = detector?.features(in: CoreImage.CIImage(cgImage: self.cgImage!))
        guard (features?.count)! > 0 else { return nil }
        let feature = features?.first as? CIQRCodeFeature
        return feature?.messageString
        
    }
    
    
    
    
    ///2.获取圆角图片
    
    func getRoundRectImage(size:CGFloat,radius:CGFloat) -> UIImage
    {
        
        return getRoundRectImage(size: size, radius: radius, borderWidth: nil, borderColor: nil)
        
    }
    
    
    ///3.获取圆角图片(带边框)
    func getRoundRectImage(size:CGFloat,radius:CGFloat,borderWidth:CGFloat?,borderColor:UIColor?) -> UIImage
    {
        let scale = self.size.width / size ;
    
        //初始值
        var defaultBorderWidth : CGFloat = 0
        var defaultBorderColor = UIColor.clear
        
        if let borderWidth = borderWidth { defaultBorderWidth = borderWidth * scale }
        if let borderColor = borderColor { defaultBorderColor = borderColor }
        
        let radius = radius * scale
        let react = CGRect(x: defaultBorderWidth, y: defaultBorderWidth, width: self.size.width - 2 * defaultBorderWidth, height: self.size.height - 2 * defaultBorderWidth)
        
        //绘制图片设置
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        
        let path = UIBezierPath(roundedRect:react , cornerRadius: radius)
        
        //绘制边框
        path.lineWidth = defaultBorderWidth
        defaultBorderColor.setStroke()
        path.stroke()

        path.addClip()
        
        //画图片
        draw(in: react)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!;
        
    }
    
    /**
     获取图片中的像素颜色值
     
     - parameter pos: 图片中的位置
     
     - returns: 颜色值
     */
    func getPixelColor(pos:CGPoint)->(alpha: CGFloat, red: CGFloat, green: CGFloat,blue:CGFloat){
        let pixelData=self.cgImage!.dataProvider!.data
        let data:UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return (a,r,g,b)
    }
    
    
    
}
