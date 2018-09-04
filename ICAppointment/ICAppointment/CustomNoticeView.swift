//
//  CustomNoticeView.swift
//  ICAppointment
//
//  Created by ICloud on 2018/4/18.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit

let IsIphoneX = UIScreen.main.bounds.size.height == 812 ? true : false
let ScreenWidth = UIScreen.main.bounds.width
let Height: CGFloat = 68.0
let HSpace: CGFloat = 8.0
let StartY: CGFloat =  -68.0
let EndY: CGFloat = IsIphoneX ? 44 : 20
let CornerRadius: CGFloat = 13.0

class CustomNoticeView: UIView {

   lazy var icon: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        return imageView
    }()
    
   lazy var title: UILabel = {
        let label = UILabel(frame: CGRect(x: 36, y: 10, width: 100, height: 20))
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.hexColor("#005c97")
        return label
    }()
    
   lazy var timeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: ScreenWidth - 16 - 100, y: 10, width: 100, height: 20))
        label.font = .systemFont(ofSize: 11)
        label.textColor = UIColor.hexColor("#005c97")
        return label
    }()
    
   lazy var messageLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 41, width: 100, height: 20))
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.hexColor("#323232")
        return label
    }()
    
    var timer: Timer?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        self.backgroundColor = .white
        self.layer.opacity = 0.618
        self.frame = CGRect(x: HSpace, y: StartY, width: ScreenWidth - 2 * HSpace, height: Height)
        self.layer.cornerRadius = CornerRadius
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.618, height: 0.618)
        self.layer.shadowOpacity = 0.618
        
        addSubview(self.icon)
        addSubview(self.title)
        addSubview(self.timeLabel)
        addSubview(self.messageLabel)
    }
    
    func showNoticeView(icon: UIImage, title: String, time: String, msg: String) {
        
        self.icon.image = icon
        self.title.text = title
        self.timeLabel.text = time
        self.messageLabel.text = msg
        self.messageLabel.sizeToFit()
        
        let oldView = self.superview?.subviews.filter({$0 is CustomNoticeView})
        UIView.animate(withDuration: 0.382, animations: {
            self.layer.opacity = 1.0
            self.frame = CGRect(x: HSpace, y: EndY, width: ScreenWidth - 2 * HSpace, height: Height)
        }) { (finish) in
            if oldView!.count > 1{
                let view = oldView?.first as! CustomNoticeView
                view.timer?.invalidate()
                view.timer = nil
                view.removeFromSuperview()
            }
        }
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(dismiss), userInfo: nil, repeats: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss()
    }
    
    @objc func dismiss(){
        UIView.animate(withDuration: 0.382, animations: {
            self.layer.opacity = 0.618
            self.frame = CGRect(x: HSpace, y: StartY, width: ScreenWidth - 2 * HSpace, height: Height)
        }) { (finish) in
            self.timer?.invalidate()
            self.timer = nil
            self.removeFromSuperview()
        }
        
    }
}
