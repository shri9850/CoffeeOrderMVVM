//
//  AddOrderViewController.swift
//  CoffeeOrderNewMVVM
//
//  Created by shree on 11/01/22.
//

import UIKit

class AddOrderViewController: UIViewController {
    private var addOrderVM: AddOrderViewModel = AddOrderViewModel()
    @IBOutlet private weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUp()
    }
    private func setUp(){
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
    }
    
    @IBAction private func saveBtnAction(_ sender: UIButton){
        addOrderVM.name = "Shrikant"
        addOrderVM.email = "Shrikant@gmail.com"
        guard let indexPath = self.tblView.indexPathForSelectedRow else {
            fatalError("Error in selecting coffee!")
        }
        addOrderVM.selectedType = self.addOrderVM.types[indexPath.row]
        addOrderVM.selectedSize = "small"
        
        webServices().loadOrder(resources: Order.addOrder(order: addOrderVM)) { (result) in
            switch result{
            case .failure(let error):
                print("Error is \(error.localizedDescription)")
            case .success(let datais):
                print("Order Data \(datais)")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }
    }
    
}
extension AddOrderViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.addOrderVM.types[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addOrderVM.types.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tblView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
}
