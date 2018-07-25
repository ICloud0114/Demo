//
//  QRScannerViewController.swift
//  QRScanner
//
//  Created by ICloud on 2018/7/25.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit
import AVFoundation
class QRScannerViewController: UIViewController {
    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var metaDataOutput: AVCaptureMetadataOutput?
    
    @IBOutlet weak var scanBoxView: UIView!
    @IBOutlet weak var scanLine: UIImageView!
    @IBOutlet var borderViews: [UIView]!
    
    @IBOutlet weak var scanQRTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = NSLocalizedString("Scan QR code", comment: "扫描二维码")
        scanQRTitleLabel.text = NSLocalizedString("Please scan the device QR code", comment: "请扫描二维码")
        
        // MARK: - 判断使用照相机的权限
       
        setupSession()
        view.bringSubview(toFront: self.scanBoxView)
        borderViews.forEach { [weak self] in
            self?.view.bringSubview(toFront: $0)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //设置扫描区域
        metaDataOutput?.rectOfInterest = (previewLayer?.metadataOutputRectConverted(fromLayerRect: scanBoxView.frame))!
        if captureSession?.isRunning == false {
            captureSession?.startRunning()
            startScanLineAnimation()
        }
        
        checkCameraRights()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkCameraRights(){
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if authStatus == .restricted || authStatus == .denied {
            //            let alert = AlertView.alert(style: .oneStyle)
            //            alert.title.text = NSLocalizedString("Notice", comment: "提示")
            //            alert.message.text = NSLocalizedString("Application of camera limited permissions, please enable in the set", comment: "应用相机权限受限,请在设置中启用")
            //            alert.icon.image = UIImage(named: "popup_prompt")
            //            alert.addAction(action: AlertAction(title: NSLocalizedString("Confirm", comment: "确定"), action: { _ in
            //                self.navigationController?.popViewController(animated: true)
            //            }))
            //            alert.actionBts[0].setBackgroundImage(UIImage.init(named: "popup_btn_normal")?.resizableImage(withCapInsets: UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)), for: .normal)
            //            alert.show(inView: self.view)
            showAlertVC()
        }else{
            
        }
    }
    
    func showAlertVC(){
        let alertVC = UIAlertController(title: "相机未授权", message: "您尚未开启迅宿智能锁APP相机授权，不能使用该功能。请到”设置-迅宿智能锁-相机“中开启", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let setting = UIAlertAction(title: "去设置", style: UIAlertActionStyle.destructive, handler: { (settingAction) in
            let settingUrl = NSURL(string: UIApplicationOpenSettingsURLString)!
            if UIApplication.shared.canOpenURL(settingUrl as URL)
            {
                UIApplication.shared.open(settingUrl as URL, options: [:], completionHandler: { (istrue) in
                })
            }
        })
        alertVC.addAction(cancel)
        alertVC.addAction(setting)
        self.present(alertVC, animated: true, completion: {
            
        })
    }
    
    func setupSession() {
        
        captureSession = AVCaptureSession()
        
        //初始化捕捉设备
        let captureDevice = AVCaptureDevice.default(for: .video)
        //用captureDevice创建输入流
        let input: AVCaptureDeviceInput?
        do {
            input = try AVCaptureDeviceInput(device: captureDevice!)
        } catch {
            return
        }
        
        //添加输入流到会话中
        if captureSession!.canAddInput(input!) {
            captureSession!.addInput(input!)
        } else {
            scanningNOtPossible()
        }
        
        //创建输出流
        metaDataOutput = AVCaptureMetadataOutput()
        if captureSession!.canAddOutput(metaDataOutput!) {
            captureSession!.addOutput(metaDataOutput!)
            metaDataOutput?.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput?.metadataObjectTypes = [.qr]
        } else {
            scanningNOtPossible()
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        previewLayer?.frame = view.layer.bounds
        previewLayer?.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
    }
    
    func scanningNOtPossible() {
        let alert = UIAlertController(title: "Can't Scan.", message: "Let's try a device equipped with a camera.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        captureSession = nil
    }
    
    func stop() {
        if captureSession?.isRunning == true {
            captureSession?.stopRunning()
        }
    }
    
    func start() {
        if captureSession?.isRunning == false {
            captureSession?.startRunning()
        }
    }
    func startScanLineAnimation() {
        //        @"transform.rotation.z"
        scanLine.isHidden = false
        let animation = CABasicAnimation(keyPath: "transform.translation.y")
        animation.duration = 3
        animation.toValue = scanBoxView.bounds.height + scanLine.bounds.height
        animation.repeatCount = Float(Int.max)
        animation.autoreverses = false
        scanLine.layer.add(animation, forKey: "transform animation")
    }
    
    func endScanLineAnimation() {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate{
    //MARK: AVCaptureMetadataOutputObjectsDelegate
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let barcodeData = metadataObjects.first , barcodeData is AVMetadataMachineReadableCodeObject {
            let barcodeReadable = barcodeData as! AVMetadataMachineReadableCodeObject
            if barcodeReadable.type == .qr {
                
                stop()
                //解析数据
                
                let codeData = barcodeReadable.stringValue?.data(using: .utf8)//.stringValue.data(using: .utf8)!
                guard let data = codeData, let _ = dataToDictionary(data: data) else {
                    scanfFailedAlertView()
                    return
                }
                let codeDict: Dictionary<String, Any>? = dataToDictionary(data: data)
                if codeDict == nil {
                    scanfFailedAlertView()
                }
                let codeStr: String = codeDict!["shareId"] as! String
                
                //判断是否是空调的有效二维码, 标志位: 0x0828
                let prekey: Int = codeDict!["prekey"] as! Int
                if prekey != 0x0828 {
                    scanfFailedAlertView()
                    return
                }
//                let deviceId: Int = Int(codeDict!["deviceId"] as! String)!
//                for device in devices {
//                    if device.id == deviceId {
//                        scanfFailedAlertView()
//                        return
//                    }
//                }
//
//                let deviceNameStr: String = codeDict!["deviceName"] as! String
//
//                let vc = TBQRCodeToAddDeviceViewController.viewController(QRCodeInfoStr: codeStr, deviceName: deviceNameStr)
//                navigationController?.pushViewController(vc, animated: true)
//                delegate?.scanned?(qrCode: barcodeReadable.stringValue ?? "")
            }
        }
    }
    
    func scanfFailedAlertView() {
        //        self.view.showMessage(NSLocalizedString("Unable to identify the QR code", comment: "无法识别二维码!"), inView: nil)
        self.start()
    }
    
    func deviceExistAlertView() {
        //        self.view.showMessage(NSLocalizedString("Device already exist", comment: "该设备已存在!"), inView: nil)
        self.start()
    }
    
    //data转字典
    func dataToDictionary(data:Data) -> Dictionary<String, Any>?{
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let dic = json as! Dictionary<String, Any>
            return dic
        } catch _ {
            //            Log("失败")
            return nil
        }
    }
}


