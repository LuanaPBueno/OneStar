//
//  ChatTableViewCell.swift
//  OneStar
//
//  Created by Luana Bueno on 13/02/25.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    var friend: Person = Person(id: "", profileName: "", receivedPhoto: false)
    var onAddFriend: (() -> Void)? // Closure para notificar o pop-up view controller
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func addingFriendButton(_ sender: Any) {
        currentUser.add(friend: friend)
        onAddFriend?()
    }
    
    func setup(friend: Person, id: Int, onAddFriend: (() -> Void)? = nil){
        self.friend = friend
        self.onAddFriend = onAddFriend  // Atribui o closure
        
        self.imageView?.image = friend.profilePicture
        self.imageView?.layer.cornerRadius = (self.imageView?.frame.width ?? 50) / 2
        self.imageView?.layer.masksToBounds = true
        
        self.textLabel?.text = friend.profileName
        self.textLabel?.font = UIFont(name: "Avenir-Heavy", size: 18)
        self.textLabel?.textColor = .black
        
        self.backgroundColor = .white
        self.selectionStyle = .none
    }
}
