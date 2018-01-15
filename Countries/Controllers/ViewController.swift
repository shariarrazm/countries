//
//  ViewController.swift
//  Countries
//
//  Created by Shariar Razm1 on 2017-10-23.
//  Copyright © 2017 Shariar Razm. All rights reserved.
//

import UIKit

final class ViewController: UITableViewController, UISearchResultsUpdating {
    
    private var countries = [Country]()
	private var filteredCountries = [Country]() {
		didSet {
			tableView.reloadData()
		}
	}
	private let cellId = "Cell"
	private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
		searchController.searchResultsUpdater = self
		searchController.hidesNavigationBarDuringPresentation = false
		searchController.dimsBackgroundDuringPresentation = false
		tableView.tableHeaderView = searchController.searchBar
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
		parseJson()
        
    }
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		searchController.dismiss(animated: false, completion: nil)
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredCountries.count
	}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as UITableViewCell
		cell.accessoryType = .disclosureIndicator
		cell.textLabel?.text = filteredCountries[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailController = DetailController()
		detailController.country = filteredCountries[indexPath.row]
		navigationController?.pushViewController(detailController, animated: true)
    }
	
	func updateSearchResults(for searchController: UISearchController) {
		if let searchText = searchController.searchBar.text, !searchText.isEmpty {
			filteredCountries = countries.filter { country in
				let result = country.name.lowercased().contains(searchText.lowercased())
				return result
			}
		} else {
			filteredCountries = []
		}
		tableView.reloadData()
	}
	
    func parseJson() {
        let urlString = "https://restcountries.eu/rest/v2/all"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [ weak self] (data, response, error) in
            guard let data = data else {return}
            do {
				self?.countries = try JSONDecoder().decode([Country].self, from: data)
                
            } catch let error {
                print("Error json", error)
            }
		}.resume()
    }
}
