//
//  ContentCell.swift
//  Solo
//
//  Created by 이지훈 on 11/17/24.
//

import UIKit

import SnapKit
import Then

class ContentCell: BaseCell {
    //변경내용
    private let titleStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
    }
    
    private let titleContentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
    }
    
    private let infoButton = UIButton().then {
        $0.setImage(UIImage(systemName: "info.circle"), for: .normal)
        $0.tintColor = .darkGray
    }
    
    private let recommendationLabel = UILabel().then {
        $0.text = "추가/수정가능, 5~900자"
        $0.textColor = .systemOrange
        $0.font = .systemFont(ofSize: 14)
    }
    
    private let voiceButton = UIButton().then {
        $0.setImage(UIImage(systemName: "mic.circle.fill"), for: .normal)
        $0.tintColor = .gray
        $0.backgroundColor = .clear
    }
    
    private let textView = UITextView().then {
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 8
        $0.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        $0.font = .systemFont(ofSize: 16)
    }
    
    private let leftStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
    }

    private let bottomStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
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
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(requiredMark)
        titleStackView.addArrangedSubview(infoButton)
        
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        titleContentStackView.addArrangedSubview(titleStackView)
        titleContentStackView.addArrangedSubview(recommendationLabel)
        
        contentView.addSubview(titleContentStackView)
        contentView.addSubview(voiceButton)
        contentView.addSubview(textView)
        contentView.addSubview(bottomStackView)
        leftStackView.addArrangedSubview(textCheckButton)
        leftStackView.addArrangedSubview(textCheckLabel)

        bottomStackView.addArrangedSubview(leftStackView)
        bottomStackView.addArrangedSubview(copyButton)
        contentView.addSubview(bottomStackView)
        
        titleContentStackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().inset(8)
        }
        
        voiceButton.snp.makeConstraints {
            $0.centerY.equalTo(titleStackView)
            $0.trailing.equalToSuperview().inset(8)
            $0.size.equalTo(24)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(titleContentStackView.snp.bottom).offset(8)
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
