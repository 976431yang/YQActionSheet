//
//  YQActionSheetCell.swift
//  YQActionSheet
//
//  Created by FreakyYang on 2018/6/2.
//  Copyright © 2018年 DaDaABC. All rights reserved.
//

import UIKit

class YQActionSheetCellConfiguration: NSObject {
    var titleColor: UIColor = UIColor.black
    var backgroundColor: UIColor = UIColor.white
    var height: CGFloat = 50
    var distanceToLeftRight: CGFloat = 0
    var blur: Bool = false
    var blurMode: UIBlurEffectStyle = .extraLight
}


class YQActionSheetCell: UIView {
    
    var config: YQActionSheetCellConfiguration = YQActionSheetCellConfiguration()
    
    var didClik: ((YQActionSheetCell) -> Void)?
    
    var title: String? {
        get{
            return titleLab.text
        }
        set{
            titleLab.text = newValue
        }
    }
    
    var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = YQActionSheetCellConfiguration().titleColor
        lab.textAlignment = .center
        return lab
    }()
    
    var blurView: UIVisualEffectView = {
        return UIVisualEffectView(effect: UIBlurEffect(style: YQActionSheetCellConfiguration().blurMode))
    }()
    
    func loadConfig() {
        titleLab.textColor = config.titleColor
        if frame.size.height != config.height {
            let newFrame = CGRect(x: config.distanceToLeftRight,
                                  y: 0,
                                  width: UIScreen.main.bounds.size.width - 2 * config.distanceToLeftRight,
                                  height: config.height)
            self.frame = newFrame
        }
        if config.blur == true {
            blurView.isHidden = false
            backgroundColor = UIColor.clear
        } else {
            blurView.isHidden = true
            backgroundColor = config.backgroundColor
        }
        blurView.effect = UIBlurEffect(style: config.blurMode)
    }
    
    init(_ configuration: YQActionSheetCellConfiguration = YQActionSheetCellConfiguration()) {
        
        super.init(frame: CGRect.zero)
        self.clipsToBounds = true
        
        addSubview(blurView)
        addSubview(titleLab)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(touched))
        addGestureRecognizer(tap)
        
        config = configuration
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        blurView.frame = bounds
        titleLab.frame = bounds
    }
    
    @objc func touched() {
        didClik?(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
