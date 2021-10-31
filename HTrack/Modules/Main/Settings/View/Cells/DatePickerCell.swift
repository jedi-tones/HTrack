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
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = titleColor
        lb.font = Styles.Fonts.soyuz1
        lb.text = "пикер"
        return lb
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .compact
        picker.maximumDate = Date()
        picker.addTarget(self, action: #selector(updateDate(sender:)), for: .valueChanged)
        picker.alpha = 0
        picker.tintColor = pickerTintColor
        picker.backgroundColor = pickerBackColor
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
        
        backgroundColor = backColor
    }
    
    func setupConstraints() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(datePicker)
        contentView.addSubview(activityIndicator)
        
        titleLabel.centerXToSuperview()
        titleLabel.topToSuperview(offset: Styles.Sizes.stadartVInset * 2)
        
        activityIndicator.centerXToSuperview()
        activityIndicator.topToBottom(of: titleLabel, offset: Styles.Sizes.stadartVInset)
        
        datePicker.centerXToSuperview()
        datePicker.topToBottom(of: titleLabel, offset: Styles.Sizes.stadartVInset)
        datePicker.bottomToSuperview(offset: -Styles.Sizes.stadartVInset * 2)
    }
}

extension DatePickerCell {
    var backColor: UIColor {
        return Styles.Colors.base3
    }
    
    var titleColor: UIColor {
        return Styles.Colors.base1
    }
    
    var pickerBackColor: UIColor {
        return Styles.Colors.base1
    }
    
    var pickerTintColor: UIColor {
        return Styles.Colors.base3
    }
}
