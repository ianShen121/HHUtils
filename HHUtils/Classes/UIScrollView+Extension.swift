//
//  UIScrollView+Extension.swift
//  HHUIKit
//
//  Created by master on 2020/1/2.
//  Copyright © 2020 com.ian.Test. All rights reserved.
//

import Foundation
import UIKit

public extension UIScrollView{
    var insetTop:CGFloat{
        get{
            return self.contentInset.top
        }
        
        set{
            var inset = contentInset
            inset.top = newValue
            contentInset = inset
        }
    }
    
    var insetBottom:CGFloat{
        get{
            return self.contentInset.bottom
        }
        
        set{
            var inset = contentInset
            inset.bottom = newValue
            contentInset = inset
        }
    }
    var insetLeft:CGFloat{
        get{
            return self.contentInset.left
        }
        
        set{
            var inset = contentInset
            inset.left = newValue
            contentInset = inset
        }
    }
    
    var insetRight:CGFloat{
        get{
            return self.contentInset.right
        }
        
        set{
            var inset = contentInset
            inset.right = newValue
            contentInset = inset
        }
    }
    
    
    var offsetX:CGFloat{
        get{
            return self.contentOffset.x
        }
        set{
            var offset = contentOffset
            offset.x = newValue
            contentOffset = offset
        }
    }
    
    var offsetY:CGFloat{
        get{
               return self.contentOffset.y
           }
           set{
               var offset = contentOffset
               offset.y = newValue
               contentOffset = offset
           }
        
    }
    
    var contentWidth:CGFloat{
        get{
            return self.contentSize.width
        }
        set{
            var size = contentSize
            size.width = newValue
            contentSize = size
        }
    }
    
    
    var contentHeight:CGFloat{
        get{
               return self.contentSize.height
           }
           set{
               var size = contentSize
               size.height = newValue
               contentSize = size
           }
    }
    
    
}
