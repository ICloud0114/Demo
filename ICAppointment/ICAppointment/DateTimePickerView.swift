//
//  DateTimePickerView.swift
//  RxExample-iOS
//
//  Created by ICloud on 2017/12/13.
//  Copyright © 2017年 Krunoslav Zaher. All rights reserved.
//

import UIKit

protocol DateTimePickerViewDelegate {
    func didFinishSelectDateTime(dateTime: String, pickerView: DateTimePickerView)
    func didCancelSelectDateTime(_ pickerView: DateTimePickerView)
}
class DateTimePickerView: UIView {

    var contentView: UIView!
    var pickerView: UIPickerView!
    var cancelButton: UIButton!
    var chooseButton: UIButton!

    var hour: Int = Date().hour
    var minute: Int = Date().minute
    
    var endHour: Int = 23
    var endMinute: Int = 59
    
    var endHourCount: Int = 24
    var endMinutesCount: Int = 60
    
    var delegate: DateTimePickerViewDelegate?
    
    override init(frame: CGRect) {
       super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        self.backgroundColor = UIColor(white: 0, alpha: 0.4)
        self.alpha = 0
        
         contentView = UIView(frame: CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 220))
        contentView.backgroundColor = .white
        self.addSubview(contentView)
        
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 40, width: self.frame.width, height: 180))
        pickerView.backgroundColor = UIColor.hexColor("#2f4f68")

        pickerView.dataSource = self
        pickerView.delegate = self
        
        contentView.addSubview(pickerView)
        //盛放按钮的View
        let upView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 40))
        upView.backgroundColor = UIColor.hexColor("#266186")
        contentView.addSubview(upView)
        //左边的取消按钮
        
        cancelButton = UIButton(type: .custom)
        cancelButton.frame = CGRect(x: 12, y: 0, width: 40, height: 40)
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.backgroundColor = .clear
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cancelButton.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        upView.addSubview(cancelButton)
        
        //右边的确定按钮
        chooseButton = UIButton(type: .custom)
        chooseButton.frame = CGRect(x: self.bounds.width - 52, y: 0, width: 40, height: 40)
        chooseButton.setTitle("确定", for: .normal)
        chooseButton.setTitleColor(.white, for: .normal)
        chooseButton.backgroundColor = .clear
        chooseButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        chooseButton.addTarget(self, action: #selector(configButtonClick), for: .touchUpInside)
        upView.addSubview(chooseButton)
        
        let titleLabel = UILabel (frame: CGRect(x: 52, y: 0, width: self.bounds.width - 104, height: 40))
        titleLabel.textColor = .white
        titleLabel.text = "新增预约"
        titleLabel.textAlignment = .center
        upView.addSubview(titleLabel)
        //分割线
//        let splitLine = UIView(frame: CGRect(x: 0, y: 40, width: self.frame.width, height: 0.5))
//        splitLine.backgroundColor = UIColor.lightGray
//        upView.addSubview(splitLine)
        
        displayCurrentDateTime(Date())
        
    }
    
    func displayCurrentDateTime(_ date: Date) {
        
        hour = date.hour
        minute = date.minute
        
        calculateEndDateTime()
    }
    
    func calculateEndDateTime(){
        
        if hour == 23 && minute > 29{
            minute = 29
        }
        endHour = (self.hour * 60 + 30 + self.minute) / 60
        endMinute = (self.hour * 60 + 30 + self.minute) % 60
        
        pickerView.reloadComponent(2)
        pickerView.reloadComponent(4)
        pickerView.reloadComponent(6)
        self.pickerView.selectRow(hour, inComponent: 0, animated: false)
        self.pickerView.selectRow(minute, inComponent: 2, animated: false)
        self.pickerView.selectRow(endHour, inComponent: 4, animated: false)
        if pickerView.selectedRow(inComponent: 4) == 0{
            self.pickerView.selectRow(endMinute - 30, inComponent: 6, animated: false)
        }else{
            self.pickerView.selectRow(endMinute, inComponent: 6, animated: false)
        }
        
        
//        calculateEndDateCount()
    }
    
    func changeEndHour(){
        if endHour - hour <= 1 {
            endMinutesCount = 60 - endMinute
        } else {
            endMinutesCount = 60
        }
        pickerView.reloadComponent(6)
    }
    
    func calculateEndDateCount(){
        
//        endHourCount = 24 - endHour
//        endMinutesCount = 60 - endMinute
    }
    
    @objc func cancelButtonClick() {
        self.delegate?.didCancelSelectDateTime(self)
    }
    
    @objc func configButtonClick(){
    
        let time = String(format: "%02d", hour) + ":" + String(format: "%02d", minute)  + "-" +  String(format: "%02d", endHour) + ":" + String(format: "%02d", endMinute)
        
        self.delegate?.didFinishSelectDateTime(dateTime: time,pickerView: self)
    }
    
}

extension DateTimePickerView:UIPickerViewDataSource,UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 8
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
            return 24
        case 2:
            if hour == 23{
                return 30
            }
            return 60
        case 4:
            return 24
        case 6:
            if endHour == 0{
                return 30
            }
            return 60
            
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var width: CGFloat = 0.0
        switch component {
        case 0:
            width = self.frame.width * 180.0 / 750
        case 1, 5:
            width = self.frame.width * 38.0 / 750
        case 2, 4, 6:
            width =  self.frame.width * 65.0 / 750
        case 3:
            width = self.frame.width * 109 / 750
        case 7:
            width = self.frame.width * 200 / 750
        default:
            break
        }
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 30))
        label.font = UIFont.systemFont(ofSize: 17.0)
        label.tag = component * 100 + row
        label.textAlignment = .center
        label.textColor = UIColor.hexColor("#00aaff")
        
        switch component {
        case 0:
            label.textAlignment = .right
            label.text = String(format: "%02d", row)
        case 2:
            label.text = String(format: "%02d", row)
            label.textAlignment = .left
        case 4:
            label.text = String(format: "%02d", row)
            label.textAlignment = .right
        case 6:
            label.text = String(format: "%02d", row)
            label.textAlignment = .left
            if pickerView.selectedRow(inComponent: 4) == 0{
                label.text = String(format: "%02d", row + 30)
            }
        case 1, 5:
            label.text = ":"
        case 3:
            label.text = "开始"
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .left
        case 7:
            label.text = "结束"
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .left
        default:
            return label
        }
        return label
        
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        
        switch component {
        case 0:
            return self.frame.width * 180.0 / 750
        case 1, 5:
           return self.frame.width * 38.0 / 750
        case 2, 4, 6:
          return  self.frame.width * 65.0 / 750
        case 3:
           return self.frame.width * 109 / 750
        case 7:
            return self.frame.width * 200 / 750
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30.0
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hour = row
            calculateEndDateTime()
        case 2:
            minute = row
            calculateEndDateTime()
        case 4:
            endHour = row
            changeEndHour()
        case 6:
            endMinute = row
        default:
            break
        }
    }

}

extension DateTimePickerView{
    
    func showDateTimePickerView(currentDate: Date) {
        
        displayCurrentDateTime(currentDate)
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
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//        hideDateTimePickerView()
//    }
}
