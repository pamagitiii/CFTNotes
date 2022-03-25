//
//  ListProtocols.swift
//  SimpleNotes
//
//  Created by Anatoliy on 25.03.2022.
//

import Foundation

enum TableControl {
    case beginUpdates
    case endUpdates
    case reload
}

enum TableActions {
    case insert
    case delete
    case move
    case update
}

protocol ListViewProtocol: AnyObject {
    
    func updateTable(_ updateType: TableControl)
    func editTable(_ editingType: TableActions, indexPath: IndexPath?, newIndexPath: IndexPath?)
    
    
    
}

protocol ListPresenterProtocol: AnyObject {
    init(view: ListViewProtocol, dataManager: CoreDataManagerProtocol, router: RouterProtocol)
    
    
    func viewDidLoad()
    var result: [Note]? { get }
    func delete(_ note: Note)
    
    func addNote()
    func editNote(_ note: Note)
}


