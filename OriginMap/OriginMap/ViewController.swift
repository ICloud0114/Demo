//
//  ViewController.swift
//  OriginMap
//
//  Created by ICloud on 2018/7/30.
//  Copyright © 2018年 ICloud. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var objectAnnotation: MKPointAnnotation?
    let locationManager:CLLocationManager = CLLocationManager()
    var isLight: Bool = false
    let la = 31.846409999999999
    let lo = 117.198775
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mapView.mapType = MKMapType.standard
        
        //创建一个MKCoordinateSpan对象，设置地图的范围（越小越精确）
        let latDelta = 0.05
        let longDelta = 0.05
        let currentLocationSpan: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        //定义地图区域和中心坐标（
        //使用当前位置
        //var center:CLLocation = locationManager.location.coordinate
        //使用自定义位置
        let center: CLLocation = CLLocation(latitude: la, longitude: lo)
        
        let currentRegion: MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate,
                                                                  span: currentLocationSpan)
        
        //设置显示区域
        mapView.setRegion(currentRegion, animated: true)
        
        //创建一个大头针对象
        objectAnnotation = MKPointAnnotation()
        //设置大头针的显示位置
        objectAnnotation?.coordinate = CLLocation(latitude: la, longitude: lo).coordinate
        //设置点击大头针之后显示的标题
//        objectAnnotation.title = "南京夫子庙"
//        //设置点击大头针之后显示的描述
//        objectAnnotation.subtitle = "南京市秦淮区秦淮河北岸中华路"
        //添加大头针
        objectAnnotation?.title = ""
        mapView.addAnnotation(objectAnnotation!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
            
        case .denied, .restricted:
            print("location access denied")
            
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func addAnnotations() {
        mapView?.delegate = self
//        mapView?.addAnnotations(places)
//
//        let overlays = places.map { MKCircle(center: $0.coordinate, radius: 100) }
//        mapView?.addOverlays(overlays)
    }

    func showAlertSheet() {
        let latitude = la
        let longitude = lo
        let alertController = UIAlertController(title: "选择导航地图", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel) { (action) in
            self.mapView.deselectAnnotation(self.objectAnnotation, animated: true)
        }
        //系统自带地图，内核高德地图，无需判断是否安装
        let appleAction = UIAlertAction(title: "自带地图", style: .default){ (action) in
            let currentLocation = MKMapItem.forCurrentLocation()
            let toLocation = MKMapItem.init(placemark: MKPlacemark.init(coordinate: (self.objectAnnotation?.coordinate)!, addressDictionary: nil))
            MKMapItem.openMaps(with: [currentLocation, toLocation],
                               launchOptions: [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                               MKLaunchOptionsShowsTrafficKey:true])
        }
        //百度地图
        if UIApplication.shared.canOpenURL(URL.init(string: "baidumap://")!) {//判断是否安装了地图
            let baiduAction = UIAlertAction(title: "百度地图", style: .default){ (action) in
                //注意：origin={{我的位置}}不要变；目的地随便写
                let urlString = "baidumap://map/direction?origin={{我的位置}}&destination=latlng:\(latitude),\(longitude)|name=目的地&mode=driving&coord_type=gcj02"
                
                let escapedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL.init(string: escapedString!)!, options: [:], completionHandler: nil)
                } else {
                    if UIApplication.shared.canOpenURL(URL.init(string: escapedString!)!) {
                        UIApplication.shared.openURL(URL.init(string: escapedString!)!)
                    }
                }
            }
            alertController.addAction(baiduAction)
        }
        //高德地图
        if UIApplication.shared.canOpenURL(URL.init(string: "iosamap://")!) {
            let gaodeAction = UIAlertAction(title: "高德地图", style: .default){ (action) in
                let urlString = "iosamap://navi?sourceApplication=随便写&backScheme=随便写&lat=\(latitude)&lon=\(longitude)&dev=0&style=2"
                let escapedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL.init(string: escapedString!)!, options: [:], completionHandler: nil)
                } else {
                    if UIApplication.shared.canOpenURL(URL.init(string: escapedString!)!) {
                        UIApplication.shared.openURL(URL.init(string: escapedString!)!)
                    }
                }
            }
            alertController.addAction(gaodeAction)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(appleAction)
        
        present(alertController, animated: true, completion: nil)
        
//
//        let alertVc = UIAlertController.init(title: "请选择地图", message: nil, preferredStyle: .actionSheet)
//        let action1 = UIAlertAction.init(title: "用百度地图导航", style: .default, handler: { (action) in
//            self.goToBaiDuMap()
//        })
//        let action2 = UIAlertAction.init(title: "用高德地图导航", style: .default, handler: { (action) in
//            self.goToGaoDeMap()
//        })
//        let cancleAction = UIAlertAction.init(title: "取消", style: .cancel, handler: { (action) in
//
//        })
//        alertVc.addAction(action1)
//        alertVc.addAction(action2)
//        alertVc.addAction(cancleAction)
//        self.present(alertVc, animated: true, completion: nil)
    }
    
    private func goToBaiDuMap() {
        //判断是否安装了百度地图
        if UIApplication.shared.canOpenURL(URL.init(string: "baidumap://")!) {//判断是否安装了地图
            let latitude = 32.029171
            let longitude = 118.788231
            let urlString = "baidumap://map/direction?origin={{我的位置}}&destination=latlng:\(latitude),\(longitude)|name=目的地&mode=driving&coord_type=gcj02"
            let escapedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL.init(string: escapedString!)!, options: [:], completionHandler: nil)
            } else {
                if UIApplication.shared.canOpenURL(URL.init(string: escapedString!)!) {
                    UIApplication.shared.openURL(URL.init(string: escapedString!)!)
                }
            }
            
        }
    }
    
    //高德地图
    private func goToGaoDeMap() {
        if UIApplication.shared.canOpenURL(URL.init(string: "iosamap://")!) {
            let latitude = 32.029171
            let longitude = 118.788231
            let urlString = "iosamap://path?sourceApplication=applicationName&sid=BGVIS1&sname=我的位置&did=BGVIS2&dname=终点&dlat=\(latitude)&dlon=\(longitude)=0&t=0"
            let escapedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL.init(string: escapedString!)!, options: [:], completionHandler: nil)
            } else {
                if UIApplication.shared.canOpenURL(URL.init(string: escapedString!)!) {
                    UIApplication.shared.openURL(URL.init(string: escapedString!)!)
                }
            }
        } else {
//            self.view.showMessage("未安装高德地图")
        }
    }
}



extension ViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
//        var customView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
       let customView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
        customView.canShowCallout = false
        customView.image = UIImage(named: "card_map_icon1")
//        if customView == nil{
//
//        }else{
//            customView?.annotation = annotation
//        }
        return customView
    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        view.image = UIImage(named: "card_map_icon1")
//        if isLight{
//            view.image = UIImage(named: "card_map_icon2")
//        }else {
//            view.image = UIImage(named: "card_map_icon1")
//        }
//        isLight = false
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        view.image = UIImage(named: "card_map_icon2")
//        isLight = true
//        mapView.deselectAnnotation(objectAnnotation, animated: true)
        showAlertSheet()
    }
    
}

