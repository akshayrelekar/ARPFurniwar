//
//  ProductListVController.swift
//  ARFurniture
//
//  Created by Akshay Relekar on 12/13/19.
//  Copyright © 2019 Akshay Relekar. All rights reserved.
//

import UIKit
import CoreData

class ProductListVController: UITableViewController,UISearchResultsUpdating,UISearchBarDelegate {

    var SegueProduct:[Product]?
    var ProductArr:[Product] = []
    
    var filteredObjects = [Product]()
    
    let searchController = UISearchController(searchResultsController: nil)
    var isfiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchBar.delegate = self
          searchController.searchResultsUpdater = self
          searchController.obscuresBackgroundDuringPresentation = false
          searchController.searchBar.placeholder = "Enter your search"
          navigationItem.searchController = searchController
          
          self.definesPresentationContext = true
          tableView.dataSource = self
          tableView.delegate = self
         self.tableView.rowHeight = 145.0
        
        if(SegueProduct?.count ?? ProductArr.count > 0){
          ProductArr = SegueProduct!
        }
        
        if(ProductArr.count > 0){
          self.navigationItem.title = ProductArr[0].categoryname
           
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(isfiltering){
            return filteredObjects.count
        }
        return ProductArr.count
    }

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
        
    }
    
    func filterContentForSearchText(_ searchText: String,
                                    category: String? = nil) {
        filteredObjects = ProductArr.filter {  (prod:Product)-> Bool in
            return prod.productName!.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
                       
                       // Configure the cell...
                       var object:Product
                       if(isfiltering){
                           object = filteredObjects[indexPath.row]
                       }else{
                        object = ProductArr[indexPath.row]
                       }
                       cell.textLabel?.text = object.productName
        //        UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 18.0 ];
        //        cell.textLabel.font  = myFont;
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                       //        cell.imageView?.image = UIImage(named: "p\(indexPath.row).jpg")
                cell.imageView?.image = UIImage(data:ProductArr[indexPath.row].productImage! )
                cell.detailTextLabel?.text = "$ " + String(format: "%\(0.2)f", object.productCost)
                cell.detailTextLabel?.font = UIFont.italicSystemFont(ofSize: 16)
                       return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
                    // Delete the row from the data source
                    PersistentService.persistentContainer.viewContext.delete(ProductArr[indexPath.row])
                                PersistentService.saveContext()
        //                           ProductArr.remove(at: indexPath.row)
                    //            ImageArray.remove(at: indexPath.row)
                               
                                tableView.deleteRows(at: [indexPath], with: .fade)
                } else if editingStyle == .insert {
                    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
                }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        guard let id = segue.identifier else {return}
        if( id == "ProductDetails"){
            let row = self.tableView.indexPathForSelectedRow?.row
            if let vd = segue.destination as? tempfile {
                vd.prodname = ProductArr[row ?? 0].productName
                vd.proddesc = ProductArr[row ?? 0].productDesc
                vd.prodspecs = ProductArr[row ?? 0].productSpec
                vd.prodprice = ProductArr[row ?? 0].productCost
                vd.productphoto = UIImage(data:ProductArr[row!].productImage!,scale:1.0)
                vd.productImgName = ProductArr[row ?? 0].productImageName
                vd.prod = ProductArr[row ?? 0]
            }
        }
    }
    
}
