//
//  PhotoCell.swift
//  saftyReport
//
//  Created by 이지훈 on 11/17/24.
//

import UIKit

import SnapKit
import Then

class PhotoCell: BaseCell {
    private let photoButton = UIButton().then {
        let attributedTitle = NSAttributedString.styled(
            text: "사진을 추가해주세요",
            style: .body9,
            alignment: .center
        )
        $0.backgroundColor = .gray3
        $0.layer.cornerRadius = 8
        $0.setAttributedTitle(attributedTitle, for: .normal)
        $0.setTitleColor(.gray7, for: .normal)
    }

    private let cameraButton = UIButton().then {
        let image = UIImage(named: "btn_i_camera")
        $0.setImage(image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }

    private let folderButton = UIButton().then {
        let image = UIImage(named: "btn_i_folder")
        $0.setImage(image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }

    private let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .fillEqually
        $0.backgroundColor = .clear
    }
    
    private var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubviews(photoButton, buttonStackView)
        buttonStackView.addArrangedSubviews(cameraButton, folderButton)

        titleLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview()
            $0.height.equalTo(24)
        }

        buttonStackView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(32)
            $0.width.equalTo(90)
        }

        [cameraButton, folderButton].forEach {
            $0.snp.makeConstraints {
                $0.size.equalTo(32)
            }
        }

        photoButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setupActions() {
        photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
    }
    
    @objc private func photoButtonTapped() {
        guard let viewController = parentViewController else { return }
        
        let contentView = createAlertContentView(image: .howToReportDetail)
        AlertManager.presentOneButtonAlert(
            title: "사진 추가",
            contentView: contentView,
            mode: .info,
            vc: viewController
        )
    }

    private func createAlertContentView(image: UIImage?) -> UIView {
        let contentView = UIView()
        let imageView = UIImageView().then {
            $0.image = image
            $0.contentMode = .scaleAspectFit
        }
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
            $0.height.equalTo(350)  
        }
        
        return contentView
    }

    
    override func configure(with item: ReportDetailItem) {
        titleLabel.text = item.title
    }
}

#Preview {
    ReportDetailViewController()
}
