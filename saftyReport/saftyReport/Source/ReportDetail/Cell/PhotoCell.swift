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
    
    private var selectedImages: [GalleryPhotoList] = [] {
        didSet {
            updateSelectedImagesUI()
        }
    }
    
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
    
    private lazy var selectedImagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SelectedImageCell.self, forCellWithReuseIdentifier: "SelectedImageCell")
        collectionView.isHidden = true
        return collectionView
    }()
    
    func updateSelectedImages(_ images: [GalleryPhotoList]) {
        selectedImages = images
        photoButton.isHidden = !selectedImages.isEmpty
        selectedImagesCollectionView.isHidden = selectedImages.isEmpty
    }
    
    private func updateSelectedImagesUI() {
        selectedImagesCollectionView.reloadData()
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
        contentView.addSubviews(photoButton, buttonStackView, selectedImagesCollectionView)
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
        
        selectedImagesCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
            $0.bottom.equalToSuperview()
        }
        
        func updateSelectedImages(_ images: [GalleryPhotoList]) {
            selectedImages = images
            photoButton.isHidden = !selectedImages.isEmpty
            selectedImagesCollectionView.isHidden = selectedImages.isEmpty
            selectedImagesCollectionView.reloadData()
        }
    }
    
    private func setupActions() {
        photoButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        cameraButton.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
    }
    
    @objc private func photoButtonTapped() {
        guard let viewController = parentViewController else { return }
        
        let contentView = createAlertContentView(image: .howToReportDetail)
        let alertVC = BaseOneButtonAlertViewController()
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        
        alertVC.setAlert("사진 추가", contentView, .info)
        
        alertVC.alertView.confirmButton.addAction(
            UIAction { [weak alertVC, weak viewController, weak self] _ in
                alertVC?.dismiss(animated: true) {
                    let galleryVC = GalleryViewController()
                    galleryVC.delegate = self
                    viewController?.navigationController?.pushViewController(galleryVC, animated: true)
                }
            },
            for: .touchUpInside
        )
        
        viewController.present(alertVC, animated: true)
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
        super.configure(with: item)
        let attributedText = NSAttributedString.styled(
            text: item.title,
            style: .body3
        )
        titleLabel.attributedText = attributedText
    }
}

extension PhotoCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SelectedImageCell",
            for: indexPath
        ) as? SelectedImageCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: selectedImages[indexPath.row])
        return cell
    }
}

extension PhotoCell: GalleryViewControllerDelegate {
    func didSelectImages(_ images: [GalleryPhotoList]) {
        print("PhotoCell에서 받은 이미지 개수:", images.count)
        print("PhotoCell에서 받은 이미지:", images)
        updateSelectedImages(images)
    }
}

#Preview {
    ReportDetailViewController()
}
