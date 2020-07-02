//
//  ChatVC.swift
//  Messenger
//
//  Created by kasper on 7/2/20.
//  Copyright © 2020 Mahmoud.Abdul-Wahab.Messenger. All rights reserved.
//

import UIKit
import MessageKit

// two struct one for the message and the other for the sender

struct Message : MessageType {
    var sender: SenderType
    
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKind
    
}

struct Sender : SenderType {
    var photoURL : String
    
    var senderId: String
    
    var displayName: String
    
    
}

///***********************************************************************************************


class ChatVC: MessagesViewController {

    private var messages = [Message]()
    
    private let selfSender = Sender(photoURL: "", senderId: "1", displayName: "Mahmoud Abdul-wahab")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .magenta
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date(), kind: .text("Hello world message ...")))
         messages.append(Message(sender: selfSender, messageId: "2", sentDate: Date(), kind: .text("Hello world messageHello world message ..Hello world message ..Hello world message ..Hello world message .. ...")))
        
    }
}

extension ChatVC : MessagesDataSource,MessagesLayoutDelegate,MessagesDisplayDelegate {
    func currentSender() -> SenderType {
        
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section] // messgaeKit use sections to separate evey single message
        // single messge per section 
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        messages.count
    }
    
    
}
