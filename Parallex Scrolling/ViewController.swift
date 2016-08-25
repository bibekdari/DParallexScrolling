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
    @IBOutlet weak var tableView: UITableView!
    
    var childScrollView: UIScrollView {
        return tableView
    }
    
    let person: [String] = ["Bean", "Roy",  "Beard", "Charles A. Beaumont and Fletcher", "Beck", "Glenn", "Becker", "Carl", "Beckett", "Samuel", "Beddoes", "Mick", "Beecher", "Henry Ward", "Beethoven", "Ludwig van", "Bean", "Roy",  "Beard", "Charles A. Beaumont and Fletcher", "Beck", "Glenn", "Becker", "Carl", "Beckett", "Samuel", "Beddoes", "Mick", "Beecher", "Henry Ward", "Beethoven", "Ludwig van"]
    
    var goingUp: Bool?
    var childScrollingDownDueToParent = false
    
    let fixedHeight: CGFloat = 25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parentScrollView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return person.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = "#\(indexPath.row)"
        cell.detailTextLabel?.text = person[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        goingUp = scrollView.panGestureRecognizer.translationInView(scrollView).y < 0
        let parentViewMaxContentYOffset = parentScrollView.contentSize.height - parentScrollView.frame.height
        if goingUp! {
            if scrollView == childScrollView {
                if parentScrollView.contentOffset.y + parentScrollView.frame.height < parentScrollView.contentSize.height && !childScrollingDownDueToParent {
                    parentScrollView.contentOffset.y = min(parentScrollView.contentOffset.y + childScrollView.contentOffset.y, parentViewMaxContentYOffset)
                    childScrollView.contentOffset.y = 0
                }
            }
        } else {
            if scrollView == childScrollView {
                if childScrollView.contentOffset.y < 0 && parentScrollView.contentOffset.y > 0 {
                    parentScrollView.contentOffset.y = max(parentScrollView.contentOffset.y - abs(childScrollView.contentOffset.y), 0)
                }
            }
            
            if scrollView == parentScrollView {
                if childScrollView.contentOffset.y > 0 && parentScrollView.contentOffset.y < parentViewMaxContentYOffset {
                    childScrollingDownDueToParent = true
                    childScrollView.contentOffset.y = max(childScrollView.contentOffset.y - (parentViewMaxContentYOffset - parentScrollView.contentOffset.y), 0)
                    parentScrollView.contentOffset.y = parentViewMaxContentYOffset
                    childScrollingDownDueToParent = false
                }
            }
        }
    }
}