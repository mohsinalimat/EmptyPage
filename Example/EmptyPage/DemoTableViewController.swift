//
//  DemoTableViewController.swift
//  EmptyPage_Example
//
//  Created by linhey on 2018/1/13.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class DemoTableViewController: UITableViewController {
  
  var rows = 0
  var sections = 1
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.separatorStyle = .none
    tableView.setEmpty(view: EmptyStates.loading)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    getData()
  }
  
  
  func getData() {
    tableView.setEmpty(view: EmptyStates.loading)
    rows = 0
    tableView.reloadData()
    sleep(3) {[weak self] in
      guard let base = self else { return }
      base.tableView.emptyView = EmptyStates.custom(block1: {[weak self] in
        guard let base = self else { return }
        base.getData()
      }) {[weak self] in
        guard let base = self else { return }
        base.rows = 1
        base.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
      }
      base.tableView.reloadData()
    }
  }
  
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return sections
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      rows -= 1
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return rows
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
    cell.textLabel?.text = "点击重新加载"
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    getData()
  }
  
}
