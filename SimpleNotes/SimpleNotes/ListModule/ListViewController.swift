//
//  ListViewController.swift
//  SimpleNotes
//
//  Created by Anatoliy on 25.03.2022.
//

import UIKit

class ListViewController: UIViewController {
    
    var presenter: ListPresenterProtocol!
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let searchController = UISearchController()
    
    private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))

    
    private let notesCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .lightGray
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "square.and.pencil")?
            .withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
        button.setBackgroundImage(image, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemGray6
        tableView.backgroundColor = .clear
        navigationItem.title = "Main"
        setupUI()
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        configureSearchBar()
        confugureTableView()
        
        presenter.viewDidLoad()
        refreshCountLbl()
    }
    
    private func setupUI() {
        view.addSubviews([tableView, visualEffectView])
        
        
        NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
        
        NSLayoutConstraint.activate([visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     visualEffectView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
                                     visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
        

        visualEffectView.contentView.addSubviews([notesCountLabel, addButton])
        
        NSLayoutConstraint.activate([notesCountLabel.centerXAnchor.constraint(equalTo: visualEffectView.centerXAnchor),
                                     notesCountLabel.centerYAnchor.constraint(equalTo: visualEffectView.centerYAnchor,  constant: -10)])
        
        NSLayoutConstraint.activate([addButton.heightAnchor.constraint(equalToConstant: 25),
                                     addButton.widthAnchor.constraint(equalToConstant: 25),
                                     addButton.centerYAnchor.constraint(equalTo: visualEffectView.centerYAnchor, constant: -10),
                                     addButton.leadingAnchor.constraint(equalTo: visualEffectView.trailingAnchor, constant: -50)])
    }
    
    private func configureSearchBar() {
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.delegate = self
    }
    
    private func confugureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(NoteCell.self)
    }
    
    func refreshCountLbl() {
        guard let count = presenter.result?.count else { return }
        notesCountLabel.text = "\(count) \(count == 1 ? "Note" : "Notes")"
    }
    
    @objc private func addButtonTapped() {
        presenter.addNote()
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cellType: NoteCell.self, for: indexPath)
        
        guard let note = presenter.result?[indexPath.row] else { return cell}
        cell.setup(note: note)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let note = presenter.result?[indexPath.row] else { return }
            presenter.delete(note)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let note = presenter.result?[indexPath.row] else { return }
        presenter.editNote(note)
    }
    
    
}

extension ListViewController: UISearchBarDelegate, UISearchControllerDelegate {
    
}

extension ListViewController: ListViewProtocol {
    func updateTable(_ updateType: TableControl) {
        switch updateType {
        case .beginUpdates:
            tableView.beginUpdates()
        case .endUpdates:
            tableView.endUpdates()
        case .reload:
            tableView.reloadData()
        }
    }
    
    func editTable(_ editingType: TableActions, indexPath: IndexPath?, newIndexPath: IndexPath?) {
        switch editingType {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        }
        refreshCountLbl()
    }
}