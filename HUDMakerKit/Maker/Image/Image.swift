//
//  Image.swift
//  HUDMakerKit
//
//  Created by AtsuyaSato on 2018/09/09.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

import Foundation

public protocol ImageModelContract {
    func image(_ img: UIImage, _ x: CGFloat, _ y: CGFloat)
    func image(_ img: UIImage, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat)
}

struct ImageModel: ImageModelContract {
    func image(_ img: UIImage, _ x: CGFloat, _ y: CGFloat) {
        let g = UIGraphicsGetCurrentContext()
        g?.saveGState()
        g?.translateBy(x: 0.0, y: img.size.height)
        g?.scaleBy(x: 1.0, y: -1.0)
        if let cgImg = img.cgImage {
            g?.draw(cgImg, in: CGRect(x: x, y: y, width: img.size.width, height: img.size.height))
        }
        g?.restoreGState()
    }

    func image(_ img: UIImage, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        let g = UIGraphicsGetCurrentContext()
        g?.saveGState()
        g?.translateBy(x: 0.0, y: height)
        g?.scaleBy(x: 1.0, y: -1.0)
        if let cgImg = img.cgImage {
            g?.draw(cgImg, in: CGRect(x: x, y: -y, width: width, height: height))
        }
        g?.restoreGState()
    }
}

extension HUDMaker: ImageModelContract {
    public func image(_ img: UIImage, _ x: CGFloat, _ y: CGFloat) {
        self.imageModel.image(img, x, y)
    }

    public func image(_ img: UIImage, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        self.imageModel.image(img, x, y, width, height)
    }
}
