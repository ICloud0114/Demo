//
//  ViewController.swift
//  TraceDemo
//
//  Created by ICloud on 2018/6/12.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var binaryLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var firstView: UIView!
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: { (t) in
            let num = Int(arc4random() % 64)
            self.numLabel.text = "\(num)"
        })
        
        let manager = FileManager.default
        let urlForCatch = manager.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
        let url = urlForCatch.first! as NSURL
        let fileName = "RookieSon.plist"
        // 创建文件
        let filesPath = creatNewFiles(name: fileName, fileBaseUrl: url)
        // 储存数据
        let saveDataInfo = NSMutableArray()
        saveDataInfo.add("我的剑,就是你的剑")
        saveDataInfo.add("我用双手成就你的梦想")
        saveDataInfo.add([1, 2, 3, 4])
        //        print(saveDataInfo)
        // 写入文件
        saveDataInfo.write(to: NSURL(string: filesPath)! as URL, atomically: true)
        
        // 读取文件
        let readDataInfo = readTheFlies(name: fileName, fileBaseUrl: url)
        print(readDataInfo)

    }
    
    func creatNewFiles(name:String, fileBaseUrl:NSURL) -> String{
        let manager = FileManager.default
        let file = fileBaseUrl.appendingPathComponent(name)
        
        let exist = manager.fileExists(atPath: file!.path)
        if !exist {
            _ = manager.createFile(atPath: file!.path, contents: nil, attributes: nil)
        }
        return (file?.absoluteString)!
    }
    
    /**
     读取文件
     
     - parameter name:        文件名
     - parameter fileBaseUrl: url
     
     - returns: 读取数据
     */
    func readTheFlies(name:String , fileBaseUrl:NSURL) ->NSString{
        let file = fileBaseUrl.appendingPathComponent(name)
        let readHandler = try! FileHandle(forReadingFrom: file!)
        let data = readHandler.readDataToEndOfFile()
        let readString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        return readString!
    }

    @IBAction func removeFirstSubview(_ sender: Any) {
        
//        firstView.removeFromSuperview()
        stackView.removeArrangedSubview(firstView)
    }
    
    @IBAction func addSubview(_ sender: Any) {
        stackView.insertArrangedSubview(firstView, at: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startOrStopAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            timer?.fireDate = Date.distantPast
        }else{
            timer?.fireDate = Date.distantFuture
            let num = Int(numLabel.text!)
            var str = String(num!, radix:2)
            if str.count < 6{
                for _ in 0 ..< 6 - str.count{
                    str.insert("0", at: str.startIndex)
                }
            }
            binaryLabel.text = str
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as! ICTableViewCell
        
        cell.adjustUI(false)
        return cell
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResuseCellIdentifier", for: indexPath)
        return cell
    }
}

