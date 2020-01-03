//
//  String+Extetion.swift
//  HHUIKit
//
//  Created by master on 2019/12/31.
//  Copyright © 2019 com.ian.Test. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto




public extension String{
    
    
    //json转成字典
    var dict:[String:Any]?{
        var json = self
               
        if json.contains("\\") {
           json = json.components(separatedBy: "\\").joined()
        }
       
       if let data = json.data(using: .utf8) {
           do {
               let array = try JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.init(rawValue: 0)]) as? Array<[String: Any]>
               
               guard let dict = array?.first else {
                   return nil
               }
               return dict
           } catch let error {
               HHLog(error)
           }
       }
       return nil
    }
    
    
    ///转成数组
    var toArray:[[String:Any]]?{
        var json = self
        
        if json.contains("\\") {
            json = json.components(separatedBy: "\\").joined()
        }

        if let data = json.data(using: .utf8) {
            do {
                let array = try JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.init(rawValue: 0)]) as? [[String: Any]]
                
                return array
            } catch let error {
                HHLog(error)
            }
        }
        return nil
        
    }
    
    
    
}



//MARK:--Common--加密

public extension String{
    
    
    
    
        // MARK:- 获取字符串高度
    func getHeigh(font: CGFloat, width: CGFloat) -> CGFloat {
        
        let statusLabelText: String = self
        let size = CGSize(width: width, height: 900)
        let dic = NSDictionary(object: UIFont.systemFont(ofSize: font), forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : Any], context:nil).size
        
        return strSize.height
        
    }
    // MARK:- 获取字符串宽度
    func getWidth(font: CGFloat, height: CGFloat) -> CGFloat {
        
        let statusLabelText: String = self
        let size = CGSize(width: 900, height: height)
        let dic = NSDictionary(object: UIFont.systemFont(ofSize: font), forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : Any], context:nil).size
        
        return strSize.width
        
    }
    
    
    //非空
    var isNotEmpty:Bool{
        return !self.isEmpty
    }
    

    ///Base64加密
    var encodingBase64:String{
        guard let data = self.data(using: .utf8) else {return ""}
        return data.base64EncodedString(options: .lineLength64Characters)
    }
    
    //Base64解密
    var decodingBase64:String{
        guard let data = self.data(using: .utf8) else {return ""}
        return String.init(data: data, encoding: .utf8) ?? ""
    }
    
    ///md5
    var md5:String{
        let utf8 = cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02X", $1) }
    
    }
    
    ///sha1
    var sha1:String{
        let data = self.data(using: String.Encoding.utf8)!

        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))

        let newData = NSData.init(data: data)

        CC_SHA1(newData.bytes, CC_LONG(data.count), &digest)

        let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))

        for byte in digest {

            output.appendFormat("%02x", byte)

            }

        return output as String
  
        
    }
    
    
    
    
    ///URL 的参数
     var urlParameters: [String: AnyObject]? {
            // 判断是否有参数
            
            guard let start = self.range(of: "?") else {
                return nil
            }
            
            var params = [String: AnyObject]()
            // 截取参数
            let index = start.upperBound
    //        let index = start.startIndex.advancedBy(1)
            let paramsString = self[index...]
            
            // 判断参数是单个参数还是多个参数
            if paramsString.contains("&") {
                
                // 多个参数，分割参数
                let urlComponents = paramsString.components(separatedBy:"&")
                
                // 遍历参数
                for keyValuePair in urlComponents {
                    // 生成Key/Value
                    let pairComponents = keyValuePair.components(separatedBy:"=")
                    let key = pairComponents.first?.removingPercentEncoding
                    let value = pairComponents.last?.removingPercentEncoding
                    // 判断参数是否是数组
                    if let key = key, let value = value {
                        // 已存在的值，生成数组
                        if let existValue = params[key] {
                            if var existValue = existValue as? [AnyObject] {
                                
                                existValue.append(value as AnyObject)
                            } else {
                                params[key] = [existValue, value] as AnyObject
                            }
                            
                        } else {
                            
                            params[key] = value as AnyObject?
                        }
                        
                    }
                }
                
            } else {
                
                // 单个参数
                let pairComponents = paramsString.components(separatedBy:"=")
                
                // 判断是否有值
                if pairComponents.count == 1 {
                    return nil
                }
                
                let key = pairComponents.first?.removingPercentEncoding
                let value = pairComponents.last?.removingPercentEncoding
                if let key = key, let value = value {
                    params[key] = value as AnyObject?
                }
                
            }
            
            
            return params
        }

    
}


//NARK:--Date
public extension String{
    
    
    ///时间戳
    var timeStamp:Int{
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        dfmatter.locale = Locale.current
        
        guard let date = dfmatter.date(from: self) else {return 0}
        
        let dateStamp:TimeInterval = date.timeIntervalSince1970
        
        let dateSt:Int = Int(dateStamp)
        
        return dateSt
       
    }
    
    //date
    var date:Date{
        let dfmatter = DateFormatter()
         dfmatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
         dfmatter.locale = Locale.current
         guard let date = dfmatter.date(from: self) else {return Date()}
        return date
    }
    
    ///计算时间，多久之前
    var timeBefore:String{
            
            let timeDate = self.date
           let currentDate = NSDate()
           
           let timeInterval = currentDate.timeIntervalSince(timeDate)
           
           var temp:Double = 0
           
           var result:String = ""
           
           if timeInterval/60 < 1 {
               
               result = "刚刚"
               
           }else if (timeInterval/60) < 60{
               
               temp = timeInterval/60
               
               result = "\(Int(temp))分钟前"
               
           }else if timeInterval/60/60 < 24 {
               
               temp = timeInterval/60/60
               
               result = "\(Int(temp))小时前"
               
           }else if timeInterval/(24 * 60 * 60) < 30 {
               
               temp = timeInterval / (24 * 60 * 60)
               
               result = "\(Int(temp))天前"
               
           }else if timeInterval/(30 * 24 * 60 * 60)  < 12 {
               
               temp = timeInterval/(30 * 24 * 60 * 60)
               
               result = "\(Int(temp))个月前"
               
           }else{
               
               temp = timeInterval/(12 * 30 * 24 * 60 * 60)
               
               result = "\(Int(temp))年前"
               
           }
           
           return result
            
    }
    
}

//MARK:--QRCode
public extension String{
    
    /**
     1.生成二维码
     
     - returns: 黑白普通二维码(大小为300)
     */
    
    
    
    var qrCode:UIImage{
         return generateQRCodeWithSize(size: nil)
    }
    

    
    /**
     2.生成二维码
     
     - parameter size: 大小
     
     - returns: 生成带大小参数的黑白普通二维码
     */
    func generateQRCodeWithSize(size:CGFloat?) -> UIImage
    {
        
        return generateQRCode(size: size, logo: nil)
        
    }
    
    
    /**
     3.生成二维码
     
     - parameter logo: 图标
     
     - returns: 生成带Logo二维码(大小:300)
     */
    func generateQRCodeWithLogo(logo:UIImage?) -> UIImage
    {
        
       return generateQRCode(size: nil, logo: logo)
        
    }
    
    
    /**
     4.生成二维码
     
     - parameter size: 大小
     - parameter logo: 图标
     
     - returns: 生成大小和Logo的二维码
     */
    func generateQRCode(size:CGFloat?,logo:UIImage?) -> UIImage
    {
        
        let color = UIColor.black//二维码颜色
        let bgColor = UIColor.white//二维码背景颜色
        
        return generateQRCode(size: size, color: color, bgColor: bgColor, logo: logo)
        
    }
    
    
    /**
     5.生成二维码
     
     - parameter size:    大小
     - parameter color:   颜色
     - parameter bgColor: 背景颜色
     - parameter logo:    图标
     
     - returns: 带Logo、颜色二维码
     */
    func generateQRCode(size:CGFloat?,color:UIColor?,bgColor:UIColor?,logo:UIImage?) -> UIImage
    {
        
        let radius : CGFloat = 5//圆角
        let borderLineWidth : CGFloat = 1.5//线宽
        let borderLineColor = UIColor.gray//线颜色
        let boderWidth : CGFloat = 8//白带宽度
        let borderColor = UIColor.white//白带颜色
        
        return generateQRCode(size: size, color: color, bgColor: bgColor, logo: logo,radius:radius,borderLineWidth: borderLineWidth,borderLineColor: borderLineColor,boderWidth: boderWidth,borderColor: borderColor)
        
    }
    
    
    /**
     6.生成二维码
     
     - parameter size:            大小
     - parameter color:           颜色
     - parameter bgColor:         背景颜色
     - parameter logo:            图标
     - parameter radius:          圆角
     - parameter borderLineWidth: 线宽
     - parameter borderLineColor: 线颜色
     - parameter boderWidth:      带宽
     - parameter borderColor:     带颜色
     
     - returns: 自定义二维码
     */
    func generateQRCode(size:CGFloat?,color:UIColor?,bgColor:UIColor?,logo:UIImage?,radius:CGFloat,borderLineWidth:CGFloat?,borderLineColor:UIColor?,boderWidth:CGFloat?,borderColor:UIColor?) -> UIImage
    {
        
        let ciImage = generateCIImage(size: size, color: color, bgColor: bgColor)
        let image = UIImage(ciImage: ciImage)
        
        guard let QRCodeLogo = logo else { return image }
        
        
        let logoWidth = image.size.width/3
        let logoFrame = CGRect(x: (image.size.width - logoWidth) /  2, y: (image.size.width - logoWidth) / 2, width: logoWidth, height: logoWidth)
        
    
        // 绘制logo
        UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        //线框
        let logoBorderLineImagae = QRCodeLogo.getRoundRectImage(size: logoWidth, radius: radius, borderWidth: borderLineWidth, borderColor: borderLineColor)
        //边框
        let logoBorderImagae = logoBorderLineImagae.getRoundRectImage(size: logoWidth, radius: radius, borderWidth: boderWidth, borderColor: borderColor)
        
        logoBorderImagae.draw(in: logoFrame)
    
        let QRCodeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        
        return QRCodeImage!
        
    }
    
    
    /**
     7.生成CIImage
     
     - parameter size:    大小
     - parameter color:   颜色
     - parameter bgColor: 背景颜色
     
     - returns: CIImage
     */
    func generateCIImage(size:CGFloat?,color:UIColor?,bgColor:UIColor?) -> CIImage
    {
        
        //1.缺省值
        var QRCodeSize : CGFloat = 300//默认300
        var QRCodeColor = UIColor.black//默认黑色二维码
        var QRCodeBgColor = UIColor.white//默认白色背景
        
        if let size = size { QRCodeSize = size }
        if let color = color { QRCodeColor = color }
        if let bgColor = bgColor { QRCodeBgColor = bgColor }
        
        
        //2.二维码滤镜
        let contentData = self.data(using: String.Encoding.utf8)
        let fileter = CIFilter(name: "CIQRCodeGenerator")
        
        fileter?.setValue(contentData, forKey: "inputMessage")
        fileter?.setValue("H", forKey: "inputCorrectionLevel")
        
        let ciImage = fileter?.outputImage
        
        
        //3.颜色滤镜
        let colorFilter = CIFilter(name: "CIFalseColor")
        
        colorFilter?.setValue(ciImage, forKey: "inputImage")
        colorFilter?.setValue(CIColor(cgColor: QRCodeColor.cgColor), forKey: "inputColor0")// 二维码颜色
        colorFilter?.setValue(CIColor(cgColor: QRCodeBgColor.cgColor), forKey: "inputColor1")// 背景色
        
        
        //4.生成处理
        
        let outImage = colorFilter!.outputImage
        let scale = QRCodeSize / outImage!.extent.size.width;
        
        
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        
        let transformImage = colorFilter!.outputImage!.transformed(by: transform)
        
        return transformImage
        
    }
    
    
    
    
    
    
    
}





public extension String{
    
    var noSpaceAndNewLine:String{
        
        get{
            return self.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: " ", with: "")
            
        }
        
    }
    
    
    
    //MAKR:---color
    var color:UIColor{
        if self.isEmpty {
            return UIColor.clear
        }
        
        var cString = self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if cString.count == 0 {
            return UIColor.clear
        }
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count < 6 && cString.count != 6 {
            
            return UIColor.clear
        }
        
        let value = "0x\(cString)"
        
        let scanner = Scanner(string:value)
        
        var hexValue : UInt64 = 0
        //查找16进制是否存在
        if scanner.scanHexInt64(&hexValue) {
            
            let redValue = CGFloat((hexValue & 0xFF0000) >> 16)/255.0
            let greenValue = CGFloat((hexValue & 0xFF00) >> 8)/255.0
            let blueValue = CGFloat(hexValue & 0xFF)/255.0
            return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1)
        }else{
            return UIColor.clear
        }
        
    }
    //MARK:--image
    var image:UIImage?{
        return UIImage.init(named: self)
    }
    
    var bool:Bool{
        return self.int == 1
    }
    
    //MARK:--Int
    var int:Int{
        return self.decimal.intValue
    }
    
    //MARK:--Int8
    var int8:Int8{
        return self.decimal.int8Value
    }
    
    //MARK:--Int16
    var int16:Int16{
        return self.decimal.int16Value
    }
    
    //MARK:--Int32
    var int32:Int32{
        return self.decimal.int32Value
    }
    
    //MARK:--Int64
    var int64:Int64{
        return self.decimal.int64Value
    }
    
    //MARK:--Double
    var double:Double{
        return self.decimal.doubleValue
    }
    
    //MARK:--Float
    var float:Float{
        return Float(self) ?? 0 //self.decimal.floatValue
    }
    
    //MARK:--cgFloat
    var cgfloat:CGFloat{
        return CGFloat(self.float)
    }
    
    //MARK:Number
    var number:NSNumber{
        return NSNumber(value: self.float)
    }
    
    //MAKR:--cut 0 at the tail
    var nozeroScale2:String{
        return transformToNumberFormort()
    }
    
    
    var decimal:NSDecimalNumber{
        let temp = NSDecimalNumber.init(string: self)
        return  temp == NSDecimalNumber.notANumber ? NSDecimalNumber.init(value: 0) : temp
    }
    
    //MARK:--addprefix
    func addPrefix(_ obj:Any)->String{
        return "\(obj)\(self)"
    }
    //MARK:--add subfix
    func addSubfix(_ obj:Any)->String{
        return "\(self)\(obj)"
    }
    //MARK:-- 字符串是否以某字符串开始
    func isBeginWith(_ str:String)->Bool{
        return NSPredicate.init(format: "SELF BEGINSWITH '\(str)' ", argumentArray: nil).evaluate(with: self)
    }
    //MARK:-- 字符串是否以某字符串介素
    func isEndWith(_ str:String)->Bool{
        return NSPredicate.init(format: "SELF ENDSWITH '\(str)' ", argumentArray: nil).evaluate(with: self)
    }
    //MARK:-- 字符串是否是http
    func isHttp()->Bool{
        return NSPredicate.init(format: "SELF LIKE 'http://*'", argumentArray: nil).evaluate(with: self)
    }
    //MARK:-- 字符串是否是https
    func isHttps()->Bool{
        return NSPredicate.init(format: "SELF LIKE 'https://*'", argumentArray: nil).evaluate(with: self)
    }
    //MARK:-- 字符串是否是ftp
    func isFtp()->Bool{
        return NSPredicate.init(format: "SELF LIKE 'ftp://*'", argumentArray: nil).evaluate(with: self)
    }
    
    //MARK:--是否是中文
    func isChinese()->Bool{
        
        let pattern = "[\u{4e00}-\u{9fa5}]+"
        let pre = NSPredicate(format: "SELF MATCHES %@", pattern)
        return pre.evaluate(with: self)
        
    }
    
    //MARK:-- 字符串是否http或者https
    func isNetUrl()->Bool{
        return isHttp() || isHttps()
    }
    //是否符合某要求
    func isMatch(_ pattern:String)->Bool{
        return NSPredicate.init(format: "SELF MATCHES %@", pattern).evaluate(with: self)
    }
    
    //MARK:--给字符串，根据正则表达式，修改其中部分字符的属性
    func setAttributesWithPattern(pattern:String,normalAttrs:[NSAttributedString.Key:Any],patternAttr:[NSAttributedString.Key:Any])->NSMutableAttributedString{
        let attributeString = NSMutableAttributedString.init(string: self, attributes: normalAttrs)
        do {
            // 数字正则表达式
            let regexExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options())
            let result = regexExpression.matches(
                in: self,
                options: NSRegularExpression.MatchingOptions(),
                range: NSMakeRange(0, count)
            )
            for item in result {
                attributeString.setAttributes(
                    patternAttr,
                    range: item.range
                )
            }
        } catch {
            print("Failed with error: \(error)")
        }
        return attributeString
    }
    
    
    
    
    
    
    //MARK:转换成数字
    func transformToNumberFormort(scale:Int16 = 2,roundMode:NSDecimalNumber.RoundingMode = .down)->String{
        let handder = NSDecimalNumberHandler.init(roundingMode: roundMode, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        let dec = self.decimal.rounding(accordingToBehavior: handder)
        return dec.stringValue
    }
    
    
    
    
    
    
    
}
