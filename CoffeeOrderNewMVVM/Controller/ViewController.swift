//
//  ViewController.swift
//  CoffeeOrderNewMVVM
//
//  Created by shree on 11/01/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var tblView: UITableView!
    var orderListVM: OrderListViewModel = OrderListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //setUP()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUP()
    }
    private func setUP(){
        webServices().loadOrder(resources: Order.create) { (result) in
            switch result{
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            case .success(let orderData):
                self.orderListVM.orderArray = orderData.map(OrderViewModel.init)
                print("Data is \(self.orderListVM.orderArray)")
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                }
            }
        }
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.orderListVM.orderArray[indexPath.row].type
        cell.detailTextLabel?.text = self.orderListVM.orderArray[indexPath.row].size
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderListVM.orderArray.count 
    }
}
