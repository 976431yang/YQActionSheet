//
//  YQActionSheet.swift
//  YQActionSheet
//
//  Created by FreakyYang on 2018/6/1.
//  Copyright © 2018年 DaDaABC. All rights reserved.
//

import UIKit

class YQActionSheetConfiguration: NSObject {
    /// 背景（半透颜色或模糊）动画进出（渐现）
    @objc public var backgroundAnimation = true
    /// 底部的选择项，动画进出（从底部）
    @objc public var cellAnimation = true
    /// 动画进出的时间
    @objc public var animationDuration: TimeInterval = 0.3
    /// 底部选项之间的间隔
    @objc public var distanceBetweenCell: CGFloat = 1
    /// 底部选项和“取消”选项之间的间隔
    @objc public var cellDistanceToCancel: CGFloat = 15
    /// 底部选项后面的颜色
    @objc public var cellClearanceColor: UIColor = UIColor(red: 0.94, green: 0.95, blue: 0.95, alpha: 0.9)
    /// 背景的颜色，建议设带透明度的颜色，在blurBack为false的时候有效
    @objc public var backgroudColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    /// 毛玻璃背景
    @objc public var blurBack: Bool = false
    /// 毛玻璃背景的风格，在blurBack为true的时候有效
    @objc public var blurMode: UIBlurEffectStyle = .dark
    /// 是否有取消选项
    @objc public var withCancel: Bool = true
    /// 取消选项的高度
    @objc public var cancelCellHeight: CGFloat = 50
    /// 标题的文字颜色
    @objc public var headerTitleColor: UIColor = UIColor.darkGray
    /// 标题高度
    @objc public var headerHeight: CGFloat = 30
    /// 点击了选项，自动隐藏
    @objc public var toucheCellAutoHide: Bool = true
}



class YQActionSheet: UIView {

    /// 配置
    @objc public var config: YQActionSheetConfiguration = YQActionSheetConfiguration()
    
    /// 选中回调
    @objc public var didSelectCell: ((_ cell: YQActionSheetCell,_ index: Int) -> Void)?
    /// 取消回调
    @objc public var didCancel: (() -> Void)?
    
    /// 展示
    @objc public func show() {
        _show()
    }
    
    /// 消失
    @objc public func dismiss() {
        _dismiss()
    }
    
    /// 对每个cell执行一次配置block
    @objc public func applyConfigForEachCell(_ config:((_ cell: YQActionSheetCell,_ index: Int) -> Void)) {
        for i in 0 ..< cells.count {
            let cell = cells[i]
            config(cell, i)
        }
        config(cancelCell, cells.count)
    }
    
    /// 所有的Cells
    @objc public var cells: [YQActionSheetCell] = []
    
    /// 取消的那行cell
    @objc public var cancelCell: YQActionSheetCell = {
        let cell = YQActionSheetCell()
        cell.title = "取消"
        return cell
    }()
    
    /// 标题Lable
    @objc public var headerLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.textColor = YQActionSheetConfiguration().headerTitleColor
        lab.textAlignment = .center
        return lab
    }()
    
    ///
    /// actionSheet初始化
    ///
    /// - Parameters:
    ///   - headerTitle: 顶部的标题（可选）
    ///   - actionTitles: 选项的标题（数组）
    ///   - configuration: actionSheet的配置（可选）
    ///   - cellCommonConfiguration: 每个选项的配置 （可选）
    ///   - selectCallBack: 选中了选项后的回调（可选）
    ///   - cancelCallBack: 选中了取消的回调（可选）
    @objc init(headerTitle: String? = nil,
               actionTitles:[String],
               configuration: YQActionSheetConfiguration? = nil,
               cellCommonConfiguration: YQActionSheetCellConfiguration? = nil,
               selectCallBack: ((_ cell: YQActionSheetCell,_ index: Int) -> Void)? = nil,
               cancelCallBack: (() -> Void)? = nil
        ) {
        super.init(frame: UIScreen.main.bounds)
        
        didSelectCell = selectCallBack
        didCancel = cancelCallBack
        
        addSubview(backgroundView)
        addSubview(cellView)
        
        cellView.addSubview(headerLab)
        if let headerTitleStr = headerTitle, !headerTitleStr.isEmpty {
            headerLab.text = headerTitleStr
        } else {
            config.headerHeight = 0
            configuration?.headerHeight = 0
        }
        for i in 0 ..< actionTitles.count {
            let title = actionTitles[i]
            let cell = YQActionSheetCell()
            cell.title = title
            
            cells.append(cell)
            cellView.addSubview(cell)
            
            cell.didClik = { [weak self] selcell in
                if self?.config.toucheCellAutoHide == true {
                    self?._dismiss()
                }
                self?.didSelectCell?(selcell,i)
            }
            
            if let userCellConfig = cellCommonConfiguration {
                cell.config = userCellConfig
            }
            
        }
        
        if let userConfiguration = configuration {
            config = userConfiguration
        }
        
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(dissmissWithCancel))
        let tapBlur = UITapGestureRecognizer(target: self, action: #selector(dissmissWithCancel))
        backgroundView.addGestureRecognizer(tapBack)
        blurView.addGestureRecognizer(tapBlur)
        cancelCell.didClik = { [weak self] _ in
            self?.dissmissWithCancel()
        }
        
    }
    
    var actionTitles: [String] = []
    var backgroundView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = YQActionSheetConfiguration().backgroudColor
        return view
    }()
    var blurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: YQActionSheetConfiguration().blurMode))
        view.frame = UIScreen.main.bounds
        return view
    }()
    var cellView: UIScrollView = {
        let scrv = UIScrollView()
        scrv.backgroundColor = YQActionSheetConfiguration().cellClearanceColor
        scrv.contentSize = CGSize.zero
        return scrv
    }()
    
    func layout() {
        backgroundColor = UIColor.clear
        
        backgroundView.alpha = 0
        backgroundView.backgroundColor = config.backgroudColor
        blurView.removeFromSuperview()
        blurView.effect = nil
        
        var cellViewHeight: CGFloat = config.headerHeight
        
        headerLab.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: config.headerHeight)
        headerLab.textColor = config.headerTitleColor
        
        for i in 0 ..< cells.count {
            let cell = cells[i]
            cell.loadConfig()
            var newCellFrame      = cell.frame
            newCellFrame.origin.y = cellViewHeight
            newCellFrame.size.height = cell.config.height
            cell.frame            = newCellFrame
            cellViewHeight += cell.config.height
            cellViewHeight += config.distanceBetweenCell
        }
        
        if config.withCancel == true {
            cancelCell.loadConfig()
            cellView.addSubview(cancelCell)
            cellViewHeight -= config.distanceBetweenCell
            cellViewHeight += config.cellDistanceToCancel
            var newCancelCellFrame      = cancelCell.frame
            newCancelCellFrame.origin.y = cellViewHeight
            if config.cancelCellHeight != cancelCell.config.height {
                config.cancelCellHeight = cancelCell.config.height
            }
            newCancelCellFrame.size.height = config.cancelCellHeight
            cancelCell.frame               = newCancelCellFrame
            cellViewHeight += config.cancelCellHeight
            cellViewHeight += config.distanceBetweenCell
        } else {
            cancelCell.removeFromSuperview()
        }
        
        if isIphoneX() == true {
             cellViewHeight += 34
            cellView.contentSize = CGSize(width: 0, height: cellViewHeight - 34)
        } else {
            cellView.contentSize = CGSize(width: 0, height: cellViewHeight)
        }
        
        let screenHeight = UIScreen.main.bounds.size.height
        
        cellView.backgroundColor = config.cellClearanceColor
        cellViewHeight = cellViewHeight > screenHeight ? screenHeight : cellViewHeight
        cellView.frame = CGRect(x: 0, y: 0,
                                width: bounds.size.width, height: cellViewHeight)
        if config.cellAnimation == true {
            cellView.alpha = 1
            var newframe      = cellView.frame
            newframe.origin.y = UIScreen.main.bounds.size.height
            cellView.frame    = newframe
        } else {
            cellView.alpha    = 0
            var newframe      = cellView.frame
            newframe.origin.y = UIScreen.main.bounds.size.height - newframe.size.height
            cellView.frame    = newframe
        }
    }
    
    @objc func dissmissWithCancel() {
        didCancel?()
        _dismiss()
    }
    
    @objc func _show() {
        layout()
        let action = { [weak self] in
            guard let weakSelf = self else { return }
            if weakSelf.config.blurBack == true, let blurV = self?.blurView {
                self?.insertSubview(blurV, belowSubview: weakSelf.cellView)
                weakSelf.blurView.effect = UIBlurEffect(style: weakSelf.config.blurMode)
            } else {
                self?.backgroundView.alpha = 1
            }
            
            if weakSelf.config.cellAnimation == true {
                var offsetY = weakSelf.cellView.contentSize.height -
                    weakSelf.cellView.bounds.size.height
                if weakSelf.isIphoneX() == true {
                    offsetY += 34
                }
                offsetY = offsetY < 0 ? 0 : offsetY
                self?.cellView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
                var newframe = weakSelf.cellView.frame
                newframe.origin.y = UIScreen.main.bounds.size.height - newframe.size.height
                self?.cellView.frame = newframe
            } else {
                self?.cellView.setContentOffset(CGPoint(x: 0, y: weakSelf.cellView.contentSize.height), animated: false)
                self?.cellView.alpha = 1
            }
        }
        
        var lastWindow = UIApplication.shared.windows.last
        if  String(describing: lastWindow).contains("Keyboard") == true {
            lastWindow = UIApplication.shared.windows[UIApplication.shared.windows.count - 2]
        }
        lastWindow?.addSubview(self)
        if config.backgroundAnimation == true {
            UIView.animate(withDuration: config.animationDuration, animations: {
                action()
            })
        } else {
            action()
        }
    }
    
    @objc func _dismiss() {
        let action = { [weak self] in
            guard let weakSelf = self else { return }
            if weakSelf.config.blurBack == true {
                self?.blurView.effect = nil
            } else {
                self?.backgroundView.alpha = 0
            }
            
            if weakSelf.config.cellAnimation == true {
                self?.cellView.setContentOffset(CGPoint.zero, animated: true)
                var newframe = weakSelf.cellView.frame
                newframe.origin.y = UIScreen.main.bounds.size.height + 100
                self?.cellView.frame = newframe
            } else {
                self?.cellView.alpha = 0
            }
        }
        
        if config.backgroundAnimation == true {
            UIView.animate(withDuration: config.animationDuration, animations: {
                action()
            }, completion: { [weak self] _ in
                self?.removeFromSuperview()
                self?.layout()
            })
        } else {
            action()
            self.removeFromSuperview()
            layout()
        }
    }
    
    func isIphoneX() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone &&
        UIApplication.shared.delegate!.window!!.safeAreaInsets.bottom > 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


