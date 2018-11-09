//
//  ViewController.swift
//  FileManagerDemo
//
//  Created by ICloud on 2018/11/6.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let path = pathForDirectoryCache(name: "demo.plist")
        
        let path =  NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        let savePath = path! + "/demo.plist"
        let str = "------------"
        
        do {
            _ = try str.write(to: URL(fileURLWithPath: savePath), atomically: true, encoding: .utf8)
        } catch _ {
            print("写入失败")
        }
        
//        let createFile = creatNewFiles(filePath: path)
//        if createFile{
//            print("-------创建文件成功")
//            do {
//                let url = URL(fileURLWithPath: path)
//                _ = try data?.write(to: url, options: Data.WritingOptions.atomic)
//                print("------写入地图数据")
//                self.mapDelegate?.didReceiveMapData()
//            } catch _ {
//                print("------写入地图数据失败")
//            }
//        }else{
//            print("-------创建文件失败")
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

