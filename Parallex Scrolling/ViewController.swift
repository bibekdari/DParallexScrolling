//
//  ViewController.swift
//  Parallex Scrolling
//
//  Created by bibek on 8/25/16.
//  Copyright © 2016 bibek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var parentScrollView: UIScrollView!
    @IBOutlet weak var childScrollView: UITableView!
    
    var goingUp: Bool?
    
    let fixedHeight: CGFloat = 25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parentScrollView.delegate = self
        childScrollView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "CELL NO \(indexPath.row)"
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        goingUp = scrollView.panGestureRecognizer.translationInView(scrollView).y < 0
        if goingUp! {
            if scrollView == childScrollView {
                if parentScrollView.contentOffset.y + parentScrollView.frame.height < parentScrollView.contentSize.height {
                    parentScrollView.contentOffset.y = min(parentScrollView.contentOffset.y + childScrollView.contentOffset.y, parentScrollView.contentSize.height - parentScrollView.frame.height)
                    childScrollView.contentOffset.y = 0
                }
            }
        }
    }
}