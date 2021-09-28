//
//  DatePickerCell.swift
//  HTrack
//
//  Created by Jedi Tones on 9/7/21.
//

import UIKit

class DatePickerCell: UICollectionViewCell, BaseCellProtocol {
    static var reuseID: String {
        return "datePickerCell"
    }
    
    var titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = Styles.Colors.myLabelColor()
        lb.font = Styles.Fonts.AvenirFonts.avenirNextBold(size: Styles.Sizes.fontSizeBase).font
        lb.text = "Пикер"
        return lb
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(updateDate(sender:)), for: .valueChanged)
        picker.alpha = 0
        picker.tintColor = Styles.Colors.myLabelColor()
        return picker
    }()
    
    var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.stopAnimating()
        return activity
    }()
    
    var needAnimationTap = true
    var viewModel: DatePickerCellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func updateDate(sender: UIDatePicker) {
        viewModel?.delegate?.dateChanged(date: sender.date)
    }
    
    func configure(viewModel: CellViewModel?) {
        guard let viewModel = viewModel as? DatePickerCellViewModel else { return }
        
        self.viewModel = viewModel
        setup()
    }
    
    func setup() {
        guard let viewModel = viewModel else { return }
        
        titleLabel.text = viewModel.title
        
        DispatchQueue.main.async { [weak self] in
            if let newDate = viewModel.startDate {
                self?.activityIndicator.stopAnimating()
                self?.datePicker.date = newDate
                self?.datePicker.alpha = 1
            } else {
                self?.datePicker.alpha = 0
                self?.activityIndicator.startAnimating()
            }
        }
        
        backgroundColor = Styles.Colors.mySecondBackgroundColor()
        layer.cornerRadius = Styles.Sizes.baseCornerRadius
    }
    
    func setupConstraints() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(datePicker)
        contentView.addSubview(activityIndicator)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: Styles.Sizes.standartHInset),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Styles.Sizes.stadartVInset),
            
            activityIndicator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Styles.Sizes.stadartVInset),
            activityIndicator.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            datePicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Styles.Sizes.stadartVInset),
            datePicker.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Styles.Sizes.stadartVInset),
        ])
    }
}
