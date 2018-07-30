//
//  AddressPickView.swift
//  Repair
//
//  Created by ICloud on 2018/7/13.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

protocol AddressPickViewDelegate {
    func didFinishSelectArea(area: String, pickerView: AddressPickView)
    func didCancelSelectArea()
}
class AddressPickView: UIView {
    
    lazy var addressSource: NSArray = {
        guard let path = Bundle.main.path(forResource: "Address", ofType: "plist"), let data = NSArray(contentsOfFile: path) else {
            fatalError()
        }
        return data
    }()
    
    var citys:[[String: [String]]] = []
    var countrys:[String] = []
    
    var contentView: UIView!
    var pickerView: UIPickerView!
    var cancelButton: UIButton!
    var chooseButton: UIButton!
    
    var dayRange: Int = 0
    var delegate: AddressPickViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        self.backgroundColor = UIColor(white: 0, alpha: 0.4)
        self.alpha = 1
        
        contentView = UIView(frame: CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 220))
        contentView.backgroundColor = .white
        self.addSubview(contentView)
        
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 40, width: self.frame.width, height: 180))
        pickerView.backgroundColor = .white
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        contentView.addSubview(pickerView)
        //盛放按钮的View
        let upView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 40))
        upView.backgroundColor = .white
        contentView.addSubview(upView)
        //左边的取消按钮
        
        cancelButton = UIButton(type: .custom)
        cancelButton.frame = CGRect(x: 12, y: 0, width: 40, height: 40)
        cancelButton.setTitle("取消", for: .normal)
//        cancelButton.setTitleColor(UIColor.hexColor("0x323232"), for: .normal)
        cancelButton.backgroundColor = .clear
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cancelButton.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        upView.addSubview(cancelButton)
        
        //右边的确定按钮
        chooseButton = UIButton(type: .custom)
        chooseButton.frame = CGRect(x: self.bounds.width - 52, y: 0, width: 40, height: 40)
        chooseButton.setTitle("确定", for: .normal)
//        chooseButton.setTitleColor(UIColor.hexColor("0x00c565"), for: .normal)
        chooseButton.backgroundColor = .clear
        chooseButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        chooseButton.addTarget(self, action: #selector(configButtonClick), for: .touchUpInside)
        upView.addSubview(chooseButton)
        
        //分割线
        let splitLine = UIView(frame: CGRect(x: 0, y: 40, width: self.frame.width, height: 0.5))
        splitLine.backgroundColor = UIColor.lightGray
        upView.addSubview(splitLine)
        
        setUpDefaultData()
    }
    
    func setUpDefaultData(){

        let provinceDict = self.addressSource[0] as! [String: Any]
        let provinceKey = provinceDict.keys.first!
        citys  = provinceDict[provinceKey] as! [[String: [String]]]
        
        let cityDic = citys.first!
        let cityKey = cityDic.keys.first!
        countrys = cityDic[cityKey]!
    }
    
    func displayCurrentDateTime(_ date: Date) {
        
//        self.pickerView.selectRow(year - startYear, inComponent: 0, animated: false)
//        self.pickerView.selectRow(date.month - 1, inComponent: 1, animated: false)
//        self.pickerView.selectRow(date.day - 1, inComponent: 2, animated: false)
//        self.pickerView.selectRow(date.hour , inComponent: 3, animated: false)
        
        
    }
    
    @objc func cancelButtonClick() {
        self.delegate?.didCancelSelectArea()
        hideDateTimePickerView()
    }
    
    @objc func configButtonClick(){
        
       let provinceLabel =  pickerView.view(forRow: pickerView.selectedRow(inComponent: 0), forComponent: 0) as? UILabel
        let cityLabel =  pickerView.view(forRow: pickerView.selectedRow(inComponent: 1), forComponent: 1) as? UILabel
        let countryLabel =  pickerView.view(forRow: pickerView.selectedRow(inComponent: 2), forComponent: 2) as? UILabel

        let area = (provinceLabel?.text)! + (cityLabel?.text)! + (countryLabel?.text)!
        
        self.delegate?.didFinishSelectArea(area: area, pickerView: self)
        
        hideDateTimePickerView()
    }
    
}

extension AddressPickView:UIPickerViewDataSource,UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
            return addressSource.count
        case 1:
            return citys.count
        case 2:
            return countrys.count
            
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: self.frame.width * CGFloat(component) / 4.0, y: 0, width: self.frame.width / 4.0, height: 30))
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.tag = component * 100 + row
        label.textAlignment = .center
        switch component {
        case 0:
            let provinceDict = self.addressSource[row] as! [String: Any]
            label.text = provinceDict.keys.first
        case 1:
            let index = citys.index(citys.startIndex, offsetBy: row)
            label.text = citys[index].keys.first
        case 2:
            label.text = countrys[row]
        default:
            break
        }
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return (self.frame.width - 20 ) / 3.0
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30.0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            
            let provinceDict = self.addressSource[row] as! [String: Any]
            let provinceKey = provinceDict.keys.first!
           citys  = provinceDict[provinceKey] as! [[String: [String]]]
            
            let cityDic = citys.first!
            let cityKey = cityDic.keys.first!
            countrys = cityDic[cityKey]!
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
        case 1:
            
            let index = citys.index(citys.startIndex, offsetBy: row)
            countrys = citys[index].values.first!
            pickerView.reloadComponent(2)
        case 2:
            let country = countrys[row]
        default:
            break
        }
    }
    
}

extension AddressPickView{
    
    func showAddressPickerView() {
        self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
            self.contentView.frame = CGRect(x: 0, y: self.bounds.height - 220, width: self.bounds.width, height: 220)
        }
    }
    
    func hideDateTimePickerView() {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
            self.contentView.frame = CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: 220)
        }) { (finish) in
            self.frame = CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: self.frame.height)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        cancelButtonClick()
    }
}
