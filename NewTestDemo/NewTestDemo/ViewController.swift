//
//  ViewController.swift
//  NewTestDemo
//
//  Created by ICloud on 30/9/2018.
//  Copyright © 2018 ICloud. All rights reserved.
//

import UIKit
/// testView
class ViewController: UIViewController {

    var pageViewController: UIPageViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pageViewController = (UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pageVC") as! UIPageViewController)
        pageViewController?.dataSource = self
        let content = viewControllerAt(index: 0)
        pageViewController?.setViewControllers([content], direction: .forward, animated: true, completion: nil)
        pageViewController?.view.frame = view.frame
        self.addChild(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController?.didMove(toParent: self)
    }


}

extension ViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let content = viewController as! ContentViewController
        var index = content.pageIndex
        if index == 0 {
            return nil
        }
        index -= 1
        return viewControllerAt(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let content = viewController as! ContentViewController
        var index = content.pageIndex
        if index == 3{
            return nil
        }
        index += 1
        return viewControllerAt(index: index)
    }
    
    func viewControllerAt(index: NSInteger) -> ContentViewController{
        let content = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "contentVC") as! ContentViewController
        content.pageIndex = index
        content.view.backgroundColor = UIColor.green
        return content
    }
}
