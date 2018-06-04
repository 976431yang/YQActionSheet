# YQActionSheet

### 微博：畸形滴小男孩
支持丰富自定义的 ActionSheet

### 效果预览
 ![image](https://github.com/976431yang/YQActionSheet/blob/master/DEMO/ScreenShot/small.gif)

### 使用方法：
-下载文件，将“YQActionSheet文件夹”直接拖到工程中使用

### 使用举例：

##### 最简单使用

```Swift
	YQActionSheet(actionTitles: ["123","234","3456","5467"]).show()
```

- 效果

 ![image](https://github.com/976431yang/YQActionSheet/blob/master/DEMO/ScreenShot/0.png)


---

##### 带标题

```Swift
	YQActionSheet(headerTitle: "标题", actionTitles: ["123","234","3456","5467"]).show()
```

- 效果

 ![image](https://github.com/976431yang/YQActionSheet/blob/master/DEMO/ScreenShot/1.png)

---

##### 毛玻璃背景

```Swift
    let actionSheet = YQActionSheet(headerTitle: "标题",
                                            actionTitles: ["123","234","3456","5467"])
    actionSheet.config.blurBack = true
    actionSheet.show()
```

- 效果

 ![image](https://github.com/976431yang/YQActionSheet/blob/master/DEMO/ScreenShot/2.png)

---

##### 更换背景毛玻璃效果

```Swift
    let actionSheet = YQActionSheet(headerTitle: "标题",
                                            actionTitles: ["123","234","3456","5467"])
    actionSheet.config.blurBack = true
    actionSheet.config.blurMode = .regular
    actionSheet.show()
```

- 效果

 ![image](https://github.com/976431yang/YQActionSheet/blob/master/DEMO/ScreenShot/3.png)

---

##### 调整cell间隔，cell背景毛玻璃

```Swift
    let actionSheet = YQActionSheet(headerTitle: "标题",
                                            actionTitles: ["123","234","3456","5467"])
            
    actionSheet.config.cellClearanceColor = UIColor.clear
    actionSheet.config.distanceBetweenCell = 10
    actionSheet.config.headerTitleColor = UIColor.white
    
    actionSheet.applyConfigForEachCell { (cell, index) in
        cell.config.distanceToLeftRight = 15
        cell.config.blur = true
        cell.layer.cornerRadius = 20
    }
    
    actionSheet.show()
```

- 效果

 ![image](https://github.com/976431yang/YQActionSheet/blob/master/DEMO/ScreenShot/4.png)

---

##### 为每个Cell单独设置效果

```Swift
    let actionSheet = YQActionSheet(actionTitles: ["123","234","3456","5467","3456","5467","5467"])
 
    actionSheet.config.cellClearanceColor = UIColor.clear
    actionSheet.config.distanceBetweenCell = 10
    actionSheet.config.backgroudColor = UIColor.clear
    actionSheet.applyConfigForEachCell { (cell, index) in
        cell.config.distanceToLeftRight = 15
        cell.config.blur = true
        if index == 0 {
            cell.config.blur = false
            cell.config.backgroundColor = UIColor(red: 1, green: 1, blue: 0, alpha: 0.5)
        } else if index == 1 {
            cell.config.blurMode = .light
        } else if index == 3 {
            cell.config.blurMode = .dark
            cell.config.titleColor = UIColor.white
        } else {
            cell.config.blurMode = .regular
        }
        cell.layer.cornerRadius = 10
    }
    actionSheet.cancelCell.config.blurMode = .regular
    
    actionSheet.show()
```

- 效果

 ![image](https://github.com/976431yang/YQActionSheet/blob/master/DEMO/ScreenShot/5.png)

---

##### 一种风格。。，

```Swift
    let actionSheet = YQActionSheet(actionTitles: ["123","234","3456","5467"])
            
    actionSheet.config.cellClearanceColor = UIColor.clear
    actionSheet.config.distanceBetweenCell = 10
    actionSheet.config.blurBack = true
    actionSheet.config.blurMode = .dark
    
    actionSheet.applyConfigForEachCell { (cell, index) in
        cell.config.distanceToLeftRight = 15
        cell.config.blur = true
        cell.config.blurMode = .extraLight
        cell.layer.cornerRadius = 10
    }
    
    actionSheet.show()
```

- 效果

 ![image](https://github.com/976431yang/YQActionSheet/blob/master/DEMO/ScreenShot/6.png)

---

##### 一种风格。。，

```Swift
    let actionSheet = YQActionSheet(headerTitle: "标题",
                                            actionTitles: ["123","234","3456","5467"])
            
    actionSheet.config.cellClearanceColor = UIColor.clear
    actionSheet.config.distanceBetweenCell = 10
    actionSheet.config.blurBack = true
    actionSheet.config.blurMode = .regular
    
    actionSheet.applyConfigForEachCell { (cell, index) in
        cell.config.distanceToLeftRight = 15
        cell.config.blur = true
        cell.config.blurMode = .extraLight
        cell.layer.cornerRadius = 20
    }
    
    actionSheet.show()
```

- 效果

 ![image](https://github.com/976431yang/YQActionSheet/blob/master/DEMO/ScreenShot/7.png)

---

##### cell非常多的情况

```Swift
    let actionSheet = YQActionSheet(headerTitle: "标题",
                                            actionTitles: ["123","234","3456","5467","234","3456","5467","234","3456","5467","234","3456","5467"])
            
    actionSheet.config.cellClearanceColor = UIColor.clear
    actionSheet.config.distanceBetweenCell = 10
    actionSheet.config.blurBack = true
    actionSheet.config.blurMode = .regular
    
    actionSheet.applyConfigForEachCell { (cell, index) in
        cell.config.distanceToLeftRight = 15
        cell.config.blur = true
        cell.config.blurMode = .extraLight
        cell.layer.cornerRadius = 20
    }
    
    actionSheet.show()
```

- 效果

 ![image](https://github.com/976431yang/YQActionSheet/blob/master/DEMO/ScreenShot/8.png)

---

##### 一种风格。。，

```Swift
    let actionSheet = YQActionSheet(headerTitle: "标题",
                                            actionTitles: ["123","234","3456","5467"])
            
    actionSheet.config.cellClearanceColor = UIColor.clear
    actionSheet.config.distanceBetweenCell = 10
    actionSheet.config.cellDistanceToCancel = 30
    actionSheet.config.blurBack = true
    actionSheet.config.blurMode = .regular
    
    actionSheet.applyConfigForEachCell { (cell, index) in
        cell.config.distanceToLeftRight = 15
        cell.config.blur = true
        cell.config.blurMode = .dark
        cell.config.titleColor = UIColor.white
        cell.layer.cornerRadius = 20
    }
    
    actionSheet.show()
```

- 效果

 ![image](https://github.com/976431yang/YQActionSheet/blob/master/DEMO/ScreenShot/9.png)

---

##### 单独设置Cell，不要取消选项

```Swift
    let actionSheet = YQActionSheet(actionTitles: ["123","234","3456","5467"])
            
	actionSheet.config.cellClearanceColor = UIColor.clear
	actionSheet.config.distanceBetweenCell = 10
	actionSheet.config.blurBack = true
	actionSheet.config.blurMode = .regular
	actionSheet.config.withCancel = false
	actionSheet.config.animationDuration = 2

	actionSheet.applyConfigForEachCell { (cell, index) in
		cell.config.distanceToLeftRight = 15
		cell.config.blur = true
		cell.config.blurMode = .dark
		cell.config.titleColor = UIColor.white
		cell.layer.cornerRadius = 20
		if index == 2 {
			cell.config.titleColor = UIColor.red
			cell.titleLab.font = UIFont.systemFont(ofSize: 20)
		}
	}

	actionSheet.show()
```

- 效果

 ![image](https://github.com/976431yang/YQActionSheet/blob/master/DEMO/ScreenShot/10.png)

---


### ActionSheet更多可配置项：

- ActionSheet的配置项，可通过“actionSheet.config.*”来配置：

```Swift
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
```

- 回调：
```Swift
	actionSheet.didSelectCell = { (cell,index) in
		// 选中回调
	}
	actionSheet.didCancel = {
		// 取消回调      
	}
```

- 手动控制显示与消失：
```Swift
	actionSheet.show()
	actionSheet.dismiss()
```

- 取出相关的控件自己调整：
```Swift
	// 所有的Cell
	actionSheet.cells
	// 取消的那行cell
	actionSheet.cancelCell
	// 标题Lable
	actionSheet.headerLab
```

### ActionSheet更多可配置项：

- ActionSheet的配置项，可通过“cell.config.*”来配置：

```Swift
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
```

- 在外层方便的对每个Cell进行配置：
```Swift
	actionSheet.applyConfigForEachCell { (cell, index) in
	    if index == 2 {
	        cell.config.****
	    }
	}
```

- 取出相关的控件自己调整：
```Swift
	// 标题
	cell.titleLab
```


