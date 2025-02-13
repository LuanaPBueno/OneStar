//
//  PopUpViewController.swift
//  OneStar
//
//  Created by Nina Leonardo Pereira Brandão on 10/02/25.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var addingFriendscontrol: UITableView!
    
    var users = Person.mockPeople()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addingFriendscontrol.delegate = self
        addingFriendscontrol.dataSource = self
    }
}

extension PopUpViewController: UITableViewDelegate {
    
}

extension PopUpViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return users.count
   }
    
    
    //OQ EU PRECISO: Que deixe a interface mais bonitinha.
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatTableViewCell
        
        let friend = users[indexPath.row]
        
        cell.setup(friend: friend , id: indexPath.row)
        
       return cell
   }
}

