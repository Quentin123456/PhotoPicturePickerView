//
//  UIImageViewExtension.swift
//  WeiboDemo
//
//  Created by Quentin Zang on 2020/3/13.
//  Copyright © 2020 臧乾坤. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// 便利构造函数
    /// - Parameter imageName: 图片名称
    convenience init(imageName: String) {
        self.init(image: UIImage(named: imageName))
    }
}
