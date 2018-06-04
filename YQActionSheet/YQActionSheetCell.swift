//
//  YQActionSheetCell.swift
//  YQActionSheet
//
//  Created by FreakyYang on 2018/6/2.
//  Copyright © 2018年 DaDaABC. All rights reserved.
//

import UIKit

class YQActionSheetCellConfiguration: NSObject {
    /// 标题的字体颜色
    @objc public var titleColor: UIColor = UIColor.black
    /// 背景的颜色，建议设带透明度的颜色，在blurBack为false的时候有效
    @objc public var backgroundColor: UIColor = UIColor.white
    /// 毛玻璃背景
    @objc public var blur: Bool = false
    /// 毛玻璃背景的风格，在blurBack为true的时候有效
    @objc public var blurMode: UIBlurEffectStyle = .extraLight
    /// 高度
    @objc public var height: CGFloat = 50
    /// 左右距离屏幕的间隔
    @objc public var distanceToLeftRight: CGFloat = 0
    /// 点击按下去的时候，遮罩的颜色
    @objc public var highlightedColor: UIColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 0.7)
}


class YQActionSheetCell: UIView {
    
    /// 配置项
    @objc public var config: YQActionSheetCellConfiguration = YQActionSheetCellConfiguration()
    
    /// 点击回调
    @objc public var didClik: ((YQActionSheetCell) -> Void)?
    
    /// 标题的Lable控件
    @objc public var titleLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textColor = YQActionSheetCellConfiguration().titleColor
        lab.textAlignment = .center
        return lab
    }()
    
    /// 标题文字，可直接修改
    @objc public var title: String? {
        get{
            return titleLab.text
        }
        set{
            titleLab.text = newValue
        }
    }
    
    var blurView: UIVisualEffectView = {
        return UIVisualEffectView(effect: UIBlurEffect(style: YQActionSheetCellConfiguration().blurMode))
    }()
    
    var touchDownMaskView: UIView = {
        let view = UIView()
        view.backgroundColor = YQActionSheetCellConfiguration().highlightedColor
        view.isUserInteractionEnabled = false
        return view
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
        touchDownMaskView.backgroundColor = config.highlightedColor
    }
    
    init(_ configuration: YQActionSheetCellConfiguration = YQActionSheetCellConfiguration()) {
        
        super.init(frame: CGRect.zero)
        self.clipsToBounds = true
        
        addSubview(blurView)
        addSubview(titleLab)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(touched))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
        
        config = configuration
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        blurView.frame = bounds
        titleLab.frame = bounds
        touchDownMaskView.frame = bounds
    }
    
    @objc func touched() {
        didClik?(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        addSubview(touchDownMaskView)
        
        UIView.animate(withDuration: 1, animations: { [weak self] in
            self?.touchDownMaskView.alpha = 0
        },completion: { [weak self] (complete) in
            if complete {
                self?.touchDownMaskView.removeFromSuperview()
                self?.touchDownMaskView.alpha = 1
            }
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
