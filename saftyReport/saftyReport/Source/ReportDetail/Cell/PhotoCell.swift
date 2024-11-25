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
       $0.backgroundColor = .gray3
       $0.layer.cornerRadius = 8
       let attributedTitle = NSAttributedString.styled(
           text: "사진을 추가해주세요",
           style: .body9
       )
       $0.setAttributedTitle(attributedTitle, for: .normal)
   }
   
   override init(frame: CGRect) {
       super.init(frame: frame)
       setupUI()
       setupAction()
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   private func setupUI() {
       contentView.addSubview(photoButton)
       
       photoButton.snp.makeConstraints {
           $0.top.equalTo(titleLabel.snp.bottom).offset(8)
           $0.leading.trailing.equalToSuperview()
           $0.height.equalTo(44)
           $0.bottom.equalToSuperview()
       }
   }
   
   private func setupAction() {
       photoButton.addTarget(
           self,
           action: #selector(photoButtonTapped),
           for: .touchUpInside
       )
   }
   
   @objc private func photoButtonTapped() {
       guard let viewController = self.findViewController() else { return }
       
       let contentView = UIView()
       let imageView = UIImageView()
       
       imageView.image = UIImage(named: "how_to_report_detail")
       imageView.contentMode = .scaleAspectFit
       
       contentView.addSubview(imageView)
       
       contentView.snp.makeConstraints {
           $0.height.equalTo(350)
       }
       
       imageView.snp.makeConstraints {
           $0.edges.top.equalToSuperview().inset(12)
           $0.edges.leading.equalToSuperview().inset(10)
       }
       
       AlertManager.presentOneButtonAlert(
           title: "신고서 작성 가이드",
           contentView: contentView,
           mode: .info,
           vc: viewController
       )
   }
   
   override func configure(with item: ReportDetailItem) {
       super.configure(with: item)
       
       let attributedTitle = NSAttributedString.styled(
           text: item.placeholder ?? "",
           style: .body9
       )
       photoButton.setAttributedTitle(attributedTitle, for: .normal)
   }
}

private extension UIView {
   func findViewController() -> UIViewController? {
       if let nextResponder = self.next as? UIViewController {
           return nextResponder
       } else if let nextResponder = self.next as? UIView {
           return nextResponder.findViewController()
       } else {
           return nil
       }
   }
}

#Preview {
    ReportDetailViewController()
}
