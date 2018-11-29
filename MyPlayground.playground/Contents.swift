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

extension String{
    func isEmail()->Bool
    {
        let email = "[A-Z0-9a-z._%+-]{3,18}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let regextestmEmail = NSPredicate(format: "SELF MATCHES %@",email)
        if (regextestmEmail.evaluate(with: self) == true){
            return true
        }else{
            return false
        }
    }
    func isPasswordFormat()->Bool
    {
        let email = "^.{6,16}$"
        let regextestmEmail = NSPredicate(format: "SELF MATCHES %@",email)
        if (regextestmEmail.evaluate(with: self) == true){
            return true
        }else{
            return false
        }
    }
}

let email = "123456&&&&&111111111111"
print(email.isPasswordFormat())
