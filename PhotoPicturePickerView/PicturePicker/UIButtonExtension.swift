//
//  UIButtonExtension.swift
//  WeiboDemo
//
//  Created by Quentin Zang on 2020/3/13.
//  Copyright © 2020 臧乾坤. All rights reserved.
//

import UIKit

extension UIButton {
    
    /// 便利构造函数
    /// - Parameters:
    ///   - imageName: 图片名称
    ///   - backgroundImageName: 背景图片名称
    convenience init(imageName: String, backgroundImageName: String) {
        
        self.init()
        
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage(named: backgroundImageName), for: .normal)
        setBackgroundImage(UIImage(named: backgroundImageName + "_highlighted"), for: .highlighted)
        
        // 会根据背景图片的大小调整大小
        sizeToFit()
    }
    
    /// 便利构造函数
    /// - Parameters:
    ///   - title: title 标题
    ///   - color: color 颜色
    ///   - imageName: 图片名称
    convenience init(title: String, color: UIColor, imageName: String) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        setBackgroundImage(UIImage(named: imageName), for: .normal)
        sizeToFit()
    }
    
    /// 便利构造函数
    /// - Parameters:
    ///   - title: title 标题
    ///   - fontSize: fontSize 字体大小
    ///   - color: color 颜色
    ///   - imageName: 图片名称
    convenience init(title: String, fontSize: CGFloat, color: UIColor, imageName: String) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        setImage(UIImage(named: imageName), for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        sizeToFit()
    }
    
}
