//
//  ViewController.swift
//  YQActionSheetDemo
//
//  Created by FreakyYang on 2018/6/2.
//  Copyright © 2018年 FreakyYang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            YQActionSheet(actionTitles: ["123","234","3456","5467"]).show()
        case 1:
            YQActionSheet(headerTitle: "标题",
                          actionTitles: ["123","234","3456","5467"]).show()
            
        case 2:
            let actionSheet = YQActionSheet(headerTitle: "标题",
                                            actionTitles: ["123","234","3456","5467"])
            actionSheet.config.blurBack = true
            actionSheet.show()
            
        case 3:
            let actionSheet = YQActionSheet(headerTitle: "标题",
                                            actionTitles: ["123","234","3456","5467"])
            actionSheet.config.blurBack = true
            actionSheet.config.blurMode = .regular
            actionSheet.show()
            
        case 4:
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
            
        case 5:
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
            
        case 6:
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
            
        case 7:
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
            
        case 8:
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
            
        case 9:
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
            
        case 10:
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
            
        default: break
        }
    }
    
    var tableView: UITableView = {
        let tabV = UITableView(frame: UIScreen.main.bounds, style: .grouped)
        tabV.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
        return tabV
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.backgroundView?.backgroundColor = UIColor.clear
        view.addSubview(tableView)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid")
        
        cell?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        cell?.textLabel?.text = "风格 \(indexPath.row)"
        
        return cell!
    }

}

