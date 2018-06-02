//
//  YQActionSheet.swift
//  YQActionSheet
//
//  Created by FreakyYang on 2018/6/1.
//  Copyright © 2018年 DaDaABC. All rights reserved.
//

import UIKit

class YQActionSheetConfiguration: NSObject {
    var backgroundAnimation = true
    var cellAnimation = true
    var animationDuration: TimeInterval = 0.3
    var distanceBetweenCell: CGFloat = 1
    var cellDistanceToCancel: CGFloat = 15
    var cellClearanceColor: UIColor = UIColor(red: 0.94, green: 0.95, blue: 0.95, alpha: 0.9)
    var backgroudColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    var blurBack: Bool = false
    var blurMode: UIBlurEffectStyle = .dark
    var withCancel: Bool = true
    var cancelCellHeight: CGFloat = 50
    var headerTitleColor: UIColor = UIColor.darkGray
    var headerHeight: CGFloat = 30
}



class YQActionSheet: UIView {

    /// 配置
    var config: YQActionSheetConfiguration = YQActionSheetConfiguration()
    
    /// 选中回调
    var didSelectCell: ((_ cell: YQActionSheetCell,_ index: Int) -> Void)?
    /// 取消回调
    var didCancel: (() -> Void)?
    
    /// 展示
    public func show() {
        _show()
    }
    
    /// 消失
    public func dismiss() {
        _dismiss()
    }
    
    /// 对每个cell执行一次配置block
    public func applyConfigForEachCell(_ config:((_ cell: YQActionSheetCell,_ index: Int) -> Void)) {
        for i in 0 ..< cells.count {
            let cell = cells[i]
            config(cell, i)
        }
        config(cancelCell, cells.count)
    }
    
    /// 所有的Cells
    public var cells: [YQActionSheetCell] = []
    
    /// 取消的那行cell
    public var cancelCell: YQActionSheetCell = {
        let cell = YQActionSheetCell()
        cell.title = "取消"
        return cell
    }()
    
    /// actionSheet初始化
    init(headerTitle: String? = nil,
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
        for title in actionTitles {
            let cell = YQActionSheetCell()
            cell.title = title
            
            cells.append(cell)
            cellView.addSubview(cell)
            
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
    var headerLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.textColor = YQActionSheetConfiguration().headerTitleColor
        lab.textAlignment = .center
        return lab
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
        
        UIApplication.shared.windows.last?.addSubview(self)
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
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        if (screenWidth == 375 && screenHeight == 812) ||
            (screenWidth == 812 && screenHeight == 375) {
            return true
        } else {
            return false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


