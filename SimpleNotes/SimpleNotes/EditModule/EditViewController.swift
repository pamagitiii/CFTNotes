//
//  EditViewController.swift
//  SimpleNotes
//
//  Created by Anatoliy on 25.03.2022.
//

import UIKit

class EditViewController: UIViewController {
    
    var presenter: EditPresenterProtocol!
    private let textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textView.becomeFirstResponder()
    }
    
    private func setupTextView() {
        textView.delegate = self
        textView.font = .systemFont(ofSize: 17)
    }
    
    private func setupUI() {
        view.addSubviews([textView])
        
        view.backgroundColor = .systemGray6
        textView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                                       constant: 20),
                                     textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                                        constant: -20)])
    }
}

extension EditViewController: EditViewProtocol {
    func setNoteText(_ text: String) {
        textView.text = text
    }
}

extension EditViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        presenter.noteEdited(textView.text)
    }
}
