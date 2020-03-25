//
//  UILabelExtension.swift
//  WeiboDemo
//
//  Created by Quentin Zang on 2020/3/13.
//  Copyright © 2020 臧乾坤. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// 便利构造函数
    /// - Parameters:
    ///   - title: 标题
    ///   - fontSize: 字体大小 默认是 14 号字体
    ///   - color: 颜色,color 的默认颜色 .darkGray
    ///   - screenInset: 相对于屏幕左右的缩进，默认为0剧中显示
    ///   - 参数不传，使用默认值
    convenience init(title: String, fontSize:CGFloat = 14, color: UIColor = .darkGray, screenInset: CGFloat = 0) {
        self.init()
        text = title
        // 界面设计上，避免使用纯黑色
        textColor = color
        font = UIFont.systemFont(ofSize: fontSize)
        numberOfLines = 0
        
        if screenInset == 0 {
            textAlignment = .center
        } else {
            // 设置换行宽度
            preferredMaxLayoutWidth = UIScreen.main.bounds.width - 2 * screenInset
            textAlignment = .left
        }
    }
}
