//
//  CodesViewController.swift
//  DecoderPractical
//
//  Created by Muvi on 07/04/19.
//  Copyright © 2019 Naruto. All rights reserved.
//

import UIKit


class CodesViewController: UIViewController {

    @IBOutlet weak var typeTF: DropDownTF!
    @IBOutlet weak var extraNavBarView: UIView!
    @IBOutlet weak var catagotyTF: DropDownTF!
    @IBOutlet weak var floatingButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var codesViewModel = [CodesViewModel]()
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryColor
        showActivityIndicatory(uiView: view)
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            self.callAPI()
            
//            DispatchQueue.main.async {
//                print("This is run on the main queue, after the previous code in outer block")
//            }
        }
        setupSearchBar()
        setupDropDown()
        setupFloatingButton()
        setupTableView()
        updateTitleView(title: "Codes", subtitle: "")
    }
    
    func callAPI() {
        APIManager.sharedInstance.getCodes(onSuccess: { (codes) in
            self.codesViewModel = codes.map({return CodesViewModel(codes: $0)})
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.actInd.stopAnimating()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    func showActivityIndicatory(uiView: UIView) {
        actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        actInd.center = uiView.center
        actInd.hidesWhenStopped = true
        actInd.style = .gray
        uiView.addSubview(actInd)
        actInd.startAnimating()
    }
    func setupDropDown() {
        typeTF.isSearchEnable = false
        typeTF.optionArray = [
            "C",
            "C++",
            "JAVA",
            "SWIFT",
            "OBJECTIVE C"
        ]
        catagotyTF.isSearchEnable = false
        catagotyTF.optionArray = [
            "Trending",
            "Most Popular",
            "Recents",
            "My Codes"
        ]
    }
    func setupFloatingButton() {
        floatingButton.layer.cornerRadius = 28
        floatingButton.layer.masksToBounds = true
        floatingButton.backgroundColor = .primaryColor
        //floatingButton.layer.zPosition = 1
        floatingButton.dropShadow(opacity: 1, radius: 4)
        
    }
    func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 108
        //tableView.register(CodeDetailsCell.self, forCellReuseIdentifier: CodeDetailsCell.CellID)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupSearchBar() {
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.clipsToBounds = true
        searchController.searchBar.tintColor = .white
        searchController.searchBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: .default)
        //searchController.searchBar.barStyle = .black
        extraNavBarView.backgroundColor = .primaryColor
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.searchBar.backgroundColor = .primaryColor
        
    }
}

extension CodesViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

extension CodesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return codesViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CodeDetailsCell.CellID, for: indexPath) as! CodeDetailsCell
        cell.codesViewModel = codesViewModel[indexPath.row]
        return cell
    }
    
}
