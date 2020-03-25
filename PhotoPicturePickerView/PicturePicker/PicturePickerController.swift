//
//  PicturePickerController.swift
//  PhotoPicturePickerView
//
//  Created by Quentin Zang on 2020/3/25.
//  Copyright © 2020 臧乾坤. All rights reserved.
//

import UIKit

// 可重用 cell
private let PicturePickerCellId = "PicturePickerCellId"

// 最大选择照片数量
private let PicturePickerMaxCount = 4

class PicturePickerController: UICollectionViewController {
    
    // 配图数组
    lazy var pictures = [UIImage]()
    
    // 当前用户选中的照片索引
    private var selectedIndex = 0

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
        
        // 保证末尾有一个加号按钮
        return pictures.count + (pictures.count == PicturePickerMaxCount ? 0 : 1)
     }

     override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicturePickerCellId, for: indexPath) as! PicturePickerCell
     
         // Configure the cell
        
        // 设置图像
        cell.image = (indexPath.item < pictures.count) ? pictures[indexPath.item] : nil
        
//        cell.backgroundColor = .red
        
        // 设置代理
        cell.pictureDelegate = self
     
         return cell
     }
}

extension PicturePickerController: PicturePickerCellDelegate {
    
    // 添加照片
    internal func PicturePickerCellAdd(cell: PicturePickerCell) {

        // 判断是否允许访问相册
        /**
            photoLibrary   保存的照片（可以删除） + 同步的照片（不允许删除）
            savePhotosAlbum 保存的照片/截屏/拍照
         */
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            print("无法访问照片库")
            return
        }
        
        // 记录当前用户选中的照片索引
        selectedIndex = collectionView.indexPath(for: cell)?.item ?? 0
        
        // 显示照片选择器
        let picker = UIImagePickerController()
        
        // 设置代理
        picker.delegate = self
        
        // 是否允许编辑
        //picker.allowsEditing = true
        
        self.present(picker, animated: true, completion: nil)
        
    }
   
    // 删除照片
    internal func PicturePickerCellRemove(cell: PicturePickerCell) {
        
        // 1.获取照片索引
        let indexPath = collectionView!.indexPath(for: cell)!
        
        // 2.判断索引是否超出上限
        if indexPath.item >= pictures.count {
            return
        }
        
        // 3.删除数据
        pictures.remove(at: indexPath.item)
        
        // 4.动画刷新视图
        collectionView.deleteItems(at: [indexPath])
        
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension PicturePickerController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// 照片选择完成
    /// - Parameters:
    ///   - picker: 照片选择器
    ///   - info: info 字典
    /// - 提示： 一旦实现代理方法，必须dismiss
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        let scaleImage = image.scaleToWidth(width: 600)
        
        
        // 将图片添加到数组
        // 判断当前选中的索引是否超出数组上限
        if selectedIndex >= pictures.count {
            pictures.append(scaleImage)
        } else {
            pictures[selectedIndex] = scaleImage
        }
        
        // 刷新视图
        collectionView.reloadData()
        
        self.dismiss(animated: true, completion: nil)
    }
}

///  PicturePickerCell 代理
@objc
protocol PicturePickerCellDelegate: NSObjectProtocol {
    
    // 添加照片
    @objc optional func PicturePickerCellAdd(cell: PicturePickerCell)
    // 删除照片
    @objc optional func PicturePickerCellRemove(cell: PicturePickerCell)
}

// MARK: - 照片选择 cell
class PicturePickerCell: UICollectionViewCell {
    
    // 照片选择代理
    weak var pictureDelegate: PicturePickerCellDelegate?
    
    var image: UIImage? {
        didSet {
            addButton.setImage(image ?? UIImage(named: "compose_pic_add"), for: .normal)
            
            // 隐藏删除按钮 image == nil 就是新增按钮
            removeButton.isHidden = (image == nil)
        }
    }
    
    
    // MARK: - 监听方法
    @objc func addPicture() {
        print("添加照片")
        pictureDelegate?.PicturePickerCellAdd?(cell: self)
    }
    
    @objc func removePicture() {
        print("删除照片")
        pictureDelegate?.PicturePickerCellRemove?(cell: self)
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
        
        // 4.设置填充模式
        addButton.imageView?.contentMode = .scaleAspectFill
        
    }
    
    // MARK: - 懒加载控件
    // 添加按钮
    private lazy var addButton: UIButton = UIButton(imageName: "compose_pic_add", backgroundImageName: "")
    // 删除按钮
    private lazy var removeButton: UIButton = UIButton(imageName: "compose_photo_close", backgroundImageName: "")
    
}
