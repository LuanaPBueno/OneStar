//
//  PopUpViewController.swift
//  OneStar
//
//  Created by Nina Leonardo Pereira Brandão on 10/02/25.
//

import UIKit

class PopUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var addingFriendscontrol: UITableView!
    
    weak var delegate: PopUpViewControllerDelegate?
    
    var users = Person.mockPeople()
    var filteredUsers: [Person] = [] 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        addingFriendscontrol.delegate = self
        addingFriendscontrol.dataSource = self
        
        filteredUsers = users
    }
    
    func addFriendAndReloadData(friend: Person) {
        users = users.filter { $0.id != friend.id }
        filteredUsers = filteredUsers.filter { $0.id != friend.id }
        addingFriendscontrol.reloadData()
        delegate?.reloadChatData()
    }
}

extension PopUpViewController {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if newText.isEmpty {
            filteredUsers = users
        } else {
            filteredUsers = users.filter { $0.profileName.lowercased().hasPrefix(newText.lowercased()) }
        }
        
        addingFriendscontrol.reloadData()
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension PopUpViewController: UITableViewDelegate {
}

extension PopUpViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatTableViewCell
        
        let friend = filteredUsers[indexPath.row]
        
        cell.setup(friend: friend, id: indexPath.row) {
            self.addFriendAndReloadData(friend: friend)
        }
        
        return cell
    }
}

// MARK: - Protocolo
protocol PopUpViewControllerDelegate: AnyObject {
    func reloadChatData()
}
