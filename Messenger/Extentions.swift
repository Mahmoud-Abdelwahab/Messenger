//
//  Extentions.swift
//  Messenger
//
//  Created by kasper on 6/29/20.
//  Copyright © 2020 Mahmoud.Abdul-Wahab.Messenger. All rights reserved.
//

import UIKit

extension UIView{
    
    public var width : CGFloat {
        return self.frame.size.width
    }
    
    
    public var height : CGFloat {
           return self.frame.size.height
       }
       
    
    public var top : CGFloat {
        return self.frame.origin.y
       }
       
    
    public var bottom : CGFloat {
        return self.frame.size.height + top
       }
       
    
    public var left : CGFloat {
        return self.frame.origin.x
          }
    
    
    public var right : CGFloat {
              return self.frame.size.width + left
             }
       
    
}

/// estentions for notification

extension Notification.Name{
    static let didLogInNotifiacation = Notification.Name("didLogInNotification")
}
