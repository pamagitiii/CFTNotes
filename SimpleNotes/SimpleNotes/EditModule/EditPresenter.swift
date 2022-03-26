//
//  EditPresenter.swift
//  SimpleNotes
//
//  Created by Anatoliy on 25.03.2022.
//

import Foundation

final class EditPresenter {

    weak var view: EditViewProtocol?
    var router: RouterProtocol?
    let dataManager: CoreDataManagerProtocol!
    var note: Note!
    
    required init(view: EditViewProtocol, dataManager: CoreDataManagerProtocol, router: RouterProtocol, note: Note) {
        self.view = view
        self.dataManager = dataManager
        self.router = router
        self.note = note
        view.setNoteText(note.text)
    }
}

extension EditPresenter: EditPresenterProtocol {
    func noteEdited(_ text: String) {
        note.text = text
        if note.title.isEmpty != true {
            note.lastUpdated = Date()
            dataManager.save()
        } else {
            dataManager.deleteNote(note)
        }
    }
}
