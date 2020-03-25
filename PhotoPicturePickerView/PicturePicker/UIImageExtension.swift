//
//  UIImageExtension.swift
//  PhotoPicturePickerView
//
//  Created by Quentin Zang on 2020/3/25.
//  Copyright © 2020 臧乾坤. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// 将图片缩放到指定的宽度
    /// - Parameter width: 目标宽度
    func scaleToWidth(width: CGFloat) -> UIImage {
        
        // 1.判断宽度
        if width > size.width {
            return self
        }
        
        // 2.计算比例
        let height = size.height * width / size.width
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        // 3.使用核心绘图绘制新的图像
        // 1.开启上下文
        UIGraphicsBeginImageContext(rect.size)
        // 2.绘图
        self.draw(in: rect)
        // 3.取结果
        let result = UIGraphicsGetImageFromCurrentImageContext()
        // 4.关闭上下文
        UIGraphicsEndPDFContext()
        // 5.返回结果
        return result!
    }
}
