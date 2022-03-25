//
//  EditProtocols.swift
//  SimpleNotes
//
//  Created by Anatoliy on 25.03.2022.
//

import Foundation

protocol EditViewProtocol: AnyObject {
    
    func setNoteText(_ text: String)
    
}

protocol EditPresenterProtocol: AnyObject {
    init(view: EditViewProtocol, dataManager: CoreDataManagerProtocol, router: RouterProtocol, note: Note)
    
    func noteEdited(_ text: String)

}
