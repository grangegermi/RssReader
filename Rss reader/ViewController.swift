//
//  ViewController.swift
//  Rss reader
//
//  Created by Даша Волошина on 31.01.23.

import UIKit
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var model = FeedParses()
    var tableView = UITableView()
    var strings:[String] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        strings = UserDefaults.standard.stringArray(forKey: "Selected") ?? []
        
        self.model.createRequest { result in}
        model.viewController = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return model.itemRss.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id, for: indexPath) as! TableViewCell
        
        cell.labelDate.text =  String((model.itemRss[indexPath.row].date!.dropLast(5)))
        cell.labelTitle.text = model.itemRss[indexPath.row].title
        cell.viewImage.sd_setImage(with: URL(string: model.itemRss[indexPath.row].image!))
        
        if strings.contains(where: { $0 == model.itemRss[indexPath.row].title}) {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
            
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        
        
        UserDefaults.standard.set(strings, forKey: "Selected")
        strings.append(model.itemRss[indexPath.row].title!)
        
        let vc = SecondViewController()
      
        vc.model = model.itemRss[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
    }
}

