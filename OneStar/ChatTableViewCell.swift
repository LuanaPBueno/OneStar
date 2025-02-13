//
//  ChatTableViewCell.swift
//  OneStar
//
//  Created by Luana Bueno on 13/02/25.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    var friend: Person = Person(id: "", profileName: "", receivedPhoto: false)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addingFriendButton(_ sender: Any) {
        currentUser.add(friend: friend)
    }
    
    func setup(friend: Person, id: Int){
        
        self.imageView?.image = friend.profilePicture
        self.imageView?.layer.cornerRadius = (self.imageView?.frame.width ?? 50) / 2
        self.imageView?.layer.masksToBounds = true
        
        self.textLabel?.text = friend.profileName
        self.textLabel?.font = UIFont(name: "Avenir-Heavy", size: 18)
        self.textLabel?.textColor = .black
        
        self.backgroundColor = .white
        self.selectionStyle = .none
        
        self.friend = friend
    }
}


