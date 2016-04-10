//
//  SelectionViewController.swift
//  PickerSelection
//
//  Created by karuna on 4/5/16.
//  Copyright © 2016 Yazh. All rights reserved.
//

import UIKit

public enum SelectionDataType : Int {
  case Default = 0
  case Users
  case Locations
  case DefectType
  case DefectSubType
  case Project
  case UnitType
  case BuildType
  case Status
}

protocol SelectionViewDelegate {
  func selectionViewController(selectionViewController:SelectionViewController, selectedObject:NSObject)
}

class SelectionViewController: UIViewController {
  
  var delegate: SelectionViewDelegate?

  var arrayData: [AnyObject]? = nil

  var selectionType: SelectionDataType? = nil
  var isShowSearch: Bool? = nil
  var arraySearchData: [AnyObject]?
  
  @IBOutlet weak var searchBar: UISearchBar?
  @IBOutlet weak var tableViewSelection: UITableView?
  @IBOutlet weak var searchHeightConstraint: NSLayoutConstraint?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.arraySearchData = [AnyObject](arrayLiteral: self.arrayData!)
    if !self.isShowSearch! {
      self.searchBar!.hidden = true
      self.searchHeightConstraint!.constant = 0
    }
  }

  // MARK: UITableView Datasource and Delegate
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.arraySearchData!.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let identifier: String = "DefaultCell"
    let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(identifier)!
    self.configureCell(cell, indexPath: indexPath)
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    self.delegate?.selectionViewController(self, selectedObject: self.arraySearchData?[indexPath.row] as! NSObject)
  }

  func configureCell(cell: UITableViewCell, indexPath: NSIndexPath) {
    if cell.respondsToSelector(Selector("preservesSuperviewLayoutMargins")) {
      cell.layoutMargins = UIEdgeInsetsZero
      cell.preservesSuperviewLayoutMargins = false
    }
    switch self.selectionType?.rawValue {
    case SelectionDataType.Default.rawValue?:
      cell.textLabel!.text = self.arraySearchData![indexPath.row] as? String
    default:
      break
    }
    
    cell.backgroundColor = UIColor.clearColor()
    cell.textLabel!.textColor = UIColor.darkGrayColor()
  }
  
  // MARK: UISearchBar Delegate

  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    self.arraySearchData?.removeAll()
    var predicate: NSPredicate = NSPredicate(format: "SELF CONTAINS[cd] %@", searchText)
    switch self.selectionType?.rawValue {
    case SelectionDataType.Users.rawValue?:
      predicate = NSPredicate(format: "SELF CONTAINS[cd] %@", searchText)
    case SelectionDataType.Locations.rawValue?:
      predicate = NSPredicate(format: "SELF.locationName CONTAINS[cd] %@", searchText)
    case SelectionDataType.DefectType.rawValue?, SelectionDataType.DefectSubType.rawValue?, SelectionDataType.Project.rawValue?, SelectionDataType.UnitType.rawValue?, SelectionDataType.BuildType.rawValue?:
      predicate = NSPredicate(format: "SELF.name CONTAINS[cd] %@", searchText)
    default:
      break
    }
    
    self.arraySearchData = arrayData!.filter { predicate.evaluateWithObject($0) }

    self.tableViewSelection!.reloadData()
  }

}