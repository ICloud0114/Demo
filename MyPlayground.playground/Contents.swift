//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"
//
//let arr = str.map({$0})
//print(arr)
//let path = "document/Logs/log1"
//let name = path.components(separatedBy: "/").last
//let index = name!.suffix(from: (name!.index((name!.startIndex), offsetBy: 3)))

//let paths = [1 , 3, 2, 100]
//
//let sortPath = paths.sorted(by: {$0 > $1})

//var index = 0
//var currentIndex: String{
//    return "\(index)"
//}
//
//index += 1
//print(currentIndex)
//index += 1
//print(currentIndex)

//extension String{
//    func isEmail()->Bool
//    {
//        let email = "[A-Z0-9a-z._%+-]{3,18}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
//        let regextestmEmail = NSPredicate(format: "SELF MATCHES %@",email)
//        if (regextestmEmail.evaluate(with: self) == true){
//            return true
//        }else{
//            return false
//        }
//    }
//    func isPasswordFormat()->Bool
//    {
//        let email = "^.{6,16}$"
//        let regextestmEmail = NSPredicate(format: "SELF MATCHES %@",email)
//        if (regextestmEmail.evaluate(with: self) == true){
//            return true
//        }else{
//            return false
//        }
//    }
//}
//
//let email = "123456&&&&&111111111111"
//print(email.isPasswordFormat())

//let byte: Int = 1 << 7
//let next = byte & (~(1 << 7))
//print(next)
////工作日 31
////周末 96
////每天
//let x = 0xff & 0
//print(x)
//let num = 127
//var str = " "
//if num & (1 << 0) != 0{
//    str += " 周一"
//}
//if num & (1 << 1) != 0{
//    str += " 周二"
//}
//if num & (1 << 2) != 0{
//    str += " 周三"
//}
//if num & (1 << 3) != 0{
//    str += " 周四"
//}
//if num & (1 << 4) != 0{
//    str += " 周五"
//}
//if num & (1 << 5) != 0{
//    str += " 周六"
//}
//if num & (1 << 6) != 0{
//    str += " 周日"
//}
//
//print(str)

//let zone = TimeZone(abbreviation: "UTC")
//let format = DateFormatter()
//format.timeZone = zone
//format.dateFormat = "yyyyMMddHHmmssZ"
//let dateStr = format.string(from: Date())
//print(UInt32(Date().timeIntervalSince1970))
//print(dateStr)
//let utcDate = format.date(from: dateStr)
//print(utcDate!.timeIntervalSince1970)

//func create(){
//    for index in 0 ... 6{
//        guard index == 2 else{
//            continue
//        }
//        print(index)
//    }
//}
//
//create()

//let list = [0, 2, -1 , 3, -3, 5, -4, -10, 7, 8]
//let sort = list.sorted { (l1, l2) -> Bool in
//    return l1 > 0
//}
//print(sort)
//for i in 0 ..< (data.length) {
//    var temp: Int32 = 0
//    //循环读取   每四个字节为长度 取值
//    if i % 4 == 0 {
//        data.getBytes(&temp, range: NSRange(location: i,length:4))
//        midelArr.append(temp)
//        if midelArr.count == 2 {
//            dataArr.append(midelArr)
//            midelArr.removeAll()
//        }
//    }
//}

var arr: [Int] = [1, 2, 3, 4]
arr.remove(at: 1)
arr.insert(0, at: 1)

