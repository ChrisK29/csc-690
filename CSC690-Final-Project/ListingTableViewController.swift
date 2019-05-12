//
//  ListingTableViewController.swift
//  CSC690-Final-Project
//
//  Created by Alex Sergeev on 5/9/19.
//  Copyright © 2019 Alex Sergeev. All rights reserved.
//

import UIKit

class ListingTableViewController: UITableViewController {
    
    var listings = [Listing]();
    let cellIdentifier = "ListingCellView"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 170.0
//        loadDefaultListings()
        self.getListings();
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listings.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ListingTableViewCell else {
            fatalError("The dequeued cell is not an instance of ListingTableViewCell.")
        }

        // Configure the cell...
        let listing = listings[indexPath.row]
        cell.housingType.text = listing.housingType
        cell.photo?.image = UIImage(data: Data(base64Encoded: listing.images[0], options: .ignoreUnknownCharacters)!)
        cell.price?.text = "$\(String(listing.price))"
        cell.roomsBathsInfo?.text = "\(listing.bedrooms!) bds | \(listing.bathrooms!) ba"
        cell.address?.text = "\(listing.line1!) \(listing.city!) \(listing.state!) \(listing.zipCode!)"
        cell.postDate?.text = listing.datePosted

        return cell
    }
 
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch segue.identifier ?? "" {
        case "ListingInfo":
            guard let viewController = segue.destination as? ListingInfoViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedCell = sender as? ListingTableViewCell else {
                fatalError("Unexpected sender: \(sender!)")
            }
            guard let indexPath = tableView.indexPath(for: selectedCell) else {
                fatalError("The selected is not being displayed by table")
            }
            let selectedListing = listings[indexPath.row]
            viewController.listing = selectedListing
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier!)")
        }
    }
    
    // MARK Private
    func loadDefaultListings(){
        
        let picture1 = UIImage(named: "listing1")
        
        // convert to base64
        let image = picture1?.pngData()?.base64EncodedString()
        
        guard let listing = Listing(title: "Sample Listing", description: "Very nice appartment in San Francisco", price: 20.01, housingType: "House", bedrooms: 3, bathrooms: 5, line1: "1 Main St.", line2: "", city: "San Francisco", state: "CA", zipCode: 94115, isApproved: true, datePosted: "May 9", images: [ image! ]) else{
            fatalError("Unable to instantiate listing")
        }
        
        listings += [ listing ]
    }

    @IBAction func onFilterPressed(_ sender: UIBarButtonItem) {
        
        let optionMenu = UIAlertController(title: nil, message: "Filter Listings", preferredStyle: .actionSheet)
        // Create Actions
        let byDateAction = UIAlertAction(title: "By Date", style: .default, handler: { _ in print("Filter by date") })
        let cheapestAction = UIAlertAction(title: "Cheapest", style: .default, handler: { _ in print("Filter by cheapest") })
        let bedroomsAction = UIAlertAction(title: "Bedrooms", style: .default, handler: {
            _ in print("Filter by bedrooms")
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        // Add Actions
        optionMenu.addAction(byDateAction)
        optionMenu.addAction(cheapestAction)
        optionMenu.addAction(bedroomsAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
    private func getListings(){
        // Make Http Request
        let url = URL(string: "http://localhost:5000/listings");
        if let url = url {
            let task = URLSession.shared.dataTask(with: url){
                (data, response, error) in
                if error != nil{
                    print("error \(error!)")
                }else{
                    if let data = data {
                        DispatchQueue.main.async {
                            //  let stringData = String(decoding: data, as: UTF8.self)
                            do {
                                let decodedListings = try JSONDecoder().decode([Listing].self, from: data)
                                print(decodedListings)
                                self.listings += decodedListings
                                self.tableView.reloadData()
                            }catch{
                                fatalError("Failed to convert data into json")
                            }
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
}
