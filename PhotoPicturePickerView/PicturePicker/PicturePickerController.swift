//
//  PicturePickerController.swift
//  PhotoPicturePickerView
//
//  Created by Quentin Zang on 2020/3/25.
//  Copyright © 2020 臧乾坤. All rights reserved.
//

import UIKit

private let PicturePickerCellId = "PicturePickerCellId"

class PicturePickerController: UICollectionViewController {
    
    // MARK: - 构造函数
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 在 collectionViewController 中 collectionView != view
        collectionView?.backgroundColor = UIColor(white: 0.9, alpha: 1.0)

        // Register cell classes
        self.collectionView!.register(PicturePickerCell.self, forCellWithReuseIdentifier: PicturePickerCellId)

    }
    
    // MARK: - 照片选择器布局
    private class PicturePickerLayout: UICollectionViewFlowLayout {
        
        override func prepare() {
            super.prepare()

            let count: CGFloat = 4
            
            let margin = UIScreen.main.scale * 4
            
            let w = (collectionView!.bounds.width - (count + 1) * margin) / count
            
            itemSize = CGSize(width: w, height: w)
            
            sectionInset = UIEdgeInsets(top: margin,left: margin,bottom: 0,right: margin)
            
            minimumLineSpacing = margin
            
            minimumInteritemSpacing = margin
            
        }
    }

}


extension PicturePickerController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         // #warning Incomplete implementation, return the number of items
         return 10
     }

     override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicturePickerCellId, for: indexPath) as! PicturePickerCell
     
         // Configure the cell
        
        cell.backgroundColor = .red
     
         return cell
     }
}


// MARK: - 照片选择 cell
class PicturePickerCell: UICollectionViewCell {
    
    // MARK: - 监听方法
    @objc func addPicture() {
        print("添加照片")
    }
    
    @objc func removePicture() {
        print("删除照片")
    }
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 设置控件
    private func setupUI() {
        
        // 1.添加控件
        contentView.addSubview(addButton)
        contentView.addSubview(removeButton)
        
        // 2.设置布局
        addButton.frame = bounds
        removeButton.snp.makeConstraints { (make) in
            make.right.equalTo(contentView.snp.right)
            make.top.equalTo(contentView.snp.top)
        }
        
        // 3.监听方法
        addButton.addTarget(self, action: #selector(addPicture), for: .touchUpInside)
        
        removeButton.addTarget(self, action: #selector(removePicture), for: .touchUpInside)
    }
    
    // MARK: - 懒加载控件
    // 添加按钮
    private lazy var addButton: UIButton = UIButton(imageName: "compose_pic_add", backgroundImageName: "")
    // 删除按钮
    private lazy var removeButton: UIButton = UIButton(imageName: "compose_photo_close", backgroundImageName: "")
    
}
