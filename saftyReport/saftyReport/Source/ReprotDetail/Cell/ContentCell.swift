//
//  ContentCell.swift
//  saftyReport
//
//  Created by 이지훈 on 11/17/24.
//

import UIKit

import SnapKit
import Then

class ContentCell: BaseCell {
    private let recommendationLabel = UILabel().then {
        $0.text = "추가/수정가능, 5~900자"
        $0.textColor = .systemOrange
        $0.font = .systemFont(ofSize: 14)
    }
    
    private let infoButton = UIImageView().then {
        let image = UIImage(named: "btn_i_mic")
        $0.image = image
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .gray6
    }
    
    private let textView = UITextView().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 8
        $0.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        $0.font = .systemFont(ofSize: 16)
    }
    
    private let bottomStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }
    
    private let leftStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
    }
    
    private let textCheckButton = UIButton().then {
        $0.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        $0.tintColor = .systemOrange
    }
    
    private let textCheckLabel = UILabel().then {
        $0.text = "추천 단어"
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 14)
    }
    
    private let copyButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "doc.on.doc")
        config.title = "내용복사"
        config.imagePadding = 4
        config.baseForegroundColor = .darkGray
        $0.configuration = config
        $0.titleLabel?.font = .systemFont(ofSize: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupPlaceholder()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [titleLabel, requiredMark, infoImageView, infoButton, recommendationLabel, textView, bottomStackView].forEach {
            contentView.addSubview($0)
        }
        
        leftStackView.addArrangedSubview(textCheckButton)
        leftStackView.addArrangedSubview(textCheckLabel)
        bottomStackView.addArrangedSubview(leftStackView)
        bottomStackView.addArrangedSubview(copyButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        requiredMark.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
        }
        
        infoImageView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(requiredMark.snp.trailing).offset(10)
            $0.size.equalTo(14)
        }
        
        infoButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        recommendationLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview()
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(recommendationLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        bottomStackView.snp.makeConstraints {
            $0.top.equalTo(textView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview()
        }
    }

    private func setupPlaceholder() {
        textView.text = "내용을 입력해주세요"
        textView.textColor = .lightGray
        textView.delegate = self
    }
    
    private func setupActions() {
        textCheckButton.addTarget(self, action: #selector(textCheckButtonTapped), for: .touchUpInside)
    }
    
    @objc private func textCheckButtonTapped() {
        textCheckButton.isSelected.toggle()
        if textCheckButton.isSelected {
            if textView.text == "내용을 입력해주세요" && textView.textColor == .lightGray {
                textView.text = "안녕하세요"
                textView.textColor = .black
            } else {
                textView.text = "안녕하세요"
            }
        } else {
            if textView.text == "안녕하세요" {
                textView.text = "내용을 입력해주세요"
                textView.textColor = .lightGray
            }
        }
    }
}

extension ContentCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력해주세요"
            textView.textColor = .lightGray
        }
    }
}

#Preview {
    ReportDetailViewController()
}
