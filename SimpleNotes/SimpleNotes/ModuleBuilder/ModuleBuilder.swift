//
//  ModuleBuilder.swift
//  SimpleNotes
//
//  Created by Anatoliy on 25.03.2022.
//

import UIKit

protocol ModuleBuilderProtocol {
    func createListModule(router: RouterProtocol) -> UIViewController
    func createEditModule(router: RouterProtocol, note: Note) -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    
    let coreDatadataManager = CoreDataManager(modelName: "SimpleNotes")
    
    func createListModule(router: RouterProtocol) -> UIViewController {
        let view = ListViewController()
        let presenter = ListPresenter(view: view, dataManager: coreDatadataManager, router: router)
        view.presenter = presenter
        return view
    }
    
    func createEditModule(router: RouterProtocol, note: Note) -> UIViewController {
        let view = EditViewController()
        let presenter = EditPresenter(view: view, dataManager: coreDatadataManager, router: router, note: note)
        view.presenter = presenter
        return view
    }
}
