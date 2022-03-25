//
//  NoteCell.swift
//  SimpleNotes
//
//  Created by Anatoliy on 25.03.2022.
//

import UIKit

final class NoteCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        //        label.adjustsFontSizeToFitWidth = true
        //        label.numberOfLines = 1
        //        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        //        label.adjustsFontSizeToFitWidth = true
        //        label.numberOfLines = 1
        //        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "chevron.right")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(note: Note) {
        titleLabel.text = note.title
        descriptionLabel.text = note.desc
    }
}

private extension NoteCell {
    func setupView() {
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        contentView.addSubviews([stackView, arrowImageView])
        
        NSLayoutConstraint.activate([arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                     arrowImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4),
                                     arrowImageView.widthAnchor.constraint(equalTo: arrowImageView.heightAnchor),
                                     arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)])
        
        
        NSLayoutConstraint.activate([stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                                     stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                                     stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
                                     stackView.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -5)])
    }
}
