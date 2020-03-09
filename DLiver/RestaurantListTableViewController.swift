//
//  RestaurantListTableViewController.swift
//  DLiver
//
//  Created by Anurag Ajwani on 12/09/2019.
//  Copyright © 2019 Anurag Ajwani. All rights reserved.
//

import UIKit

class RestaurantListTableViewController: UITableViewController {
    
    private let restaurantLister: RestaurantLister = ServerRestaurantLister()
    private var restuarants: [Restaurant]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.restaurantLister.get(onCompletion: { self.restuarants = $0 })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restuarants?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let restaurants = self.restuarants {
            let restuarant = restaurants[indexPath.row]
            return self.getRestaurantCell(tableView, forRestaurant: restuarant)
        } else {
            return self.getLoadingCell(tableView)
        }
    }
    
    private func getLoadingCell(_ tableView: UITableView) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "loadingCell")!
    }
    
    private func getRestaurantCell(_ tableView: UITableView, forRestaurant restaurant: Restaurant) -> UITableViewCell {
        let restuarantCell = tableView.dequeueReusableCell(withIdentifier: "restuarantCell") as! RestaurantTableViewCell
        restuarantCell.bind(viewData: self.convertRestaurantToCellViewData(restaurant))
        return restuarantCell
    }
    
    private func convertRestaurantToCellViewData(_ restuarant: Restaurant) -> RestaurantTableViewCell.ViewData {
        let cuisinesText = restuarant
            .cuisines
            .enumerated()
            .reduce("", { (result, next: (index: Int, element: Cuisine)) -> String in
                if next.index == 0 {
                    return next.element.rawValue
                } else {
                    return "\(result) • \(next.element.rawValue)"
                }
            })
        return RestaurantTableViewCell.ViewData(
            nameText: restuarant.name,
            cuisinesText: cuisinesText)
    }
}
