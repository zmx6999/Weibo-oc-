//
//  IFSEmojiTool.swift
//  Weibo
//
//  Created by zmx on 16/3/18.
//  Copyright © 2016年 zmx. All rights reserved.
//

import UIKit

class IFSEmojiTool: NSObject {
    
    class func getEmojiStr(code: String?) ->String? {
        let scannner = NSScanner(string: code ?? "")
        var value: UInt32 = 0
        scannner.scanHexInt(&value)
        let c = Character(UnicodeScalar(value))
        return "\(c)"
    }

}
