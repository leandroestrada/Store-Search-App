//
//  ViewController.swift
//  StoreSearchApp
//
//  Created by le on 07/10/18.
//  Copyright © 2018 its. All rights reserved.
//
//
import UIKit


class ViewController: UIViewController {
    
    var searchResults = [SearchResult]()
    var hasSearched = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        let cellNib = UINib(nibName: "SearchResultCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "SearchResultCell")
        
        
    }


}

extension ViewController: UISearchBarDelegate{
    func position(for bar: UIBarPositioning) -> UIBarPosition{
        return .topAttached
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if searchBar.text! != ""{
        for i in 0...10{
            let searchResult = SearchResult()
            searchResult.name = String(format: "Fake Result %d for", i)
            searchResult.artistName = searchBar.text!
            searchResults.append(searchResult)
            }
        }
        hasSearched = true
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  !hasSearched{
            return 0
        }  else if searchResults.count == 0{
            return 1
        }else {
            return searchResults.count
          }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if searchResults.count == 0{
            return nil
        }else{
            return indexPath
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
        
//        let cellIdentifier = "SearchResultCell"
//
//        var cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
//
//        if cell == nil{
//            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
//        }
        if searchResults.count == 0{
            cell.nameLabel.text = "(Nothing found)"
            cell.artistNameLabel.text = ""
        }else{
        let searchResult = searchResults[indexPath.row]
        cell.nameLabel.text = searchResult.name
        cell.artistNameLabel.text = searchResult.artistName
        }
        return cell
    }
}

