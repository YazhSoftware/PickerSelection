//
//  ViewController.swift
//  PickerSelection
//
//  Created by karuna on 4/5/16.
//  Copyright © 2016 Yazh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SelectionViewDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  @IBAction func onUnitTypeButtonPressed(sender: UIButton) {
    let arrayData = ["Villa Type 1","Villa Type 2","Villa Type 3","Villa Type 4"]
    showSelectionViewType(.Default, arrayData:arrayData, source: sender, contentSize: CGSize(width: 200, height: 200), showSearch: false)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  func showSelectionViewType(type:SelectionDataType, arrayData: NSArray, source:UIView, contentSize:CGSize, showSearch:Bool) {
    var frame: CGRect
    let selectionView: SelectionViewController = SelectionViewController(nibName: "SelectionViewController", bundle: nil)
    selectionView.selectionType = type
    selectionView.arrayData = arrayData as [AnyObject]
    selectionView.modalPresentationStyle = .Popover
    selectionView.preferredContentSize = CGSizeMake(source.frame.size.width, 50)
    selectionView.delegate = self
    selectionView.isShowSearch = showSearch
    frame = selectionView.view.frame
    selectionView.view.frame = CGRectZero
    selectionView.view.backgroundColor = UIColor.clearColor()
    let popover: UIPopoverPresentationController = selectionView.popoverPresentationController!
    popover.sourceView = source
    popover.permittedArrowDirections = .Up
    popover.sourceRect = CGRectMake(0, 0, source.frame.size.width, source.frame.size.height)
    popover.backgroundColor = UIColor.whiteColor()
    self.presentViewController(selectionView, animated: false, completion: {() -> Void in
      UIView.animateWithDuration(0.5, animations: {() -> Void in
        selectionView.preferredContentSize = CGSizeMake(source.frame.size.width, contentSize.height)
        selectionView.view.frame = frame
      })
    })
  }

  func selectionViewController(selectionViewController:SelectionViewController, selectedObject:NSObject) {
    
  }
}

