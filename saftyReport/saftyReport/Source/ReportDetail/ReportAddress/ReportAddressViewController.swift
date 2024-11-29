//
//  ReportAddressViewController.swift
//  saftyReport
//
//  Created by OneTen on 11/24/24.
//

import UIKit

import SnapKit
import Then

protocol ReportAddressDelegate: AnyObject {
    func didSelectAddress(_ address: String)
}

class ReportAddressViewController: UIViewController {
    weak var delegate: ReportAddressDelegate?
    
    private let baseView = UIView()
    
    private let imageView = UIImageView().then {
        $0.image = .reportAddress
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray6.cgColor
    }
    
    private let addressView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray5.cgColor
        $0.layer.cornerRadius = 5
    }
    
    private let locationIconImage = UIImageView().then {
        $0.image = .icnLocationLineBlack24Px
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .primaryOrange
    }
    
    private let addressLabel = UILabel().then {
        $0.attributedText = .styled(text: "서울특별시 마포구 땡땡12로 3", style: .body8)
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .primaryOrange
    }
    
    private lazy var searchKeywordButton = UIButton().then {
        $0.setAttributedTitle(NSAttributedString.styled(text: "키워드 검색", style: .body4), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        $0.setTitleColor(.gray8, for: .normal)
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray5.cgColor
        $0.addTarget(self, action: #selector(searchKeywordButtonTapped), for: .touchUpInside)
    }
    
    private lazy var searchAddressButton = UIButton().then {
        $0.setAttributedTitle(NSAttributedString.styled(text: "주소 검색", style: .body4), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        $0.setTitleColor(.gray8, for: .normal)
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.primaryOrange.cgColor
        $0.addTarget(self, action: #selector(searchAddressButtonTapped), for: .touchUpInside)
    }
    
    private lazy var selectButton = UIButton().then {
        $0.setAttributedTitle(NSAttributedString.styled(text: "위치 선택", style: .body4), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        $0.setTitleColor(.gray1, for: .normal)
        $0.backgroundColor = .primaryOrange
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setUI() {
        self.view.addSubview(baseView)
        baseView.addSubviews(imageView, addressView, searchKeywordButton, searchAddressButton, selectButton)
        addressView.addSubviews(locationIconImage, addressLabel)
    }
    
    private func setLayout() {
        baseView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.width.equalTo(345)
            $0.height.equalTo(343)
        }
        
        addressView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.width.equalTo(345)
            $0.height.equalTo(47)
        }
        
        locationIconImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.verticalEdges.equalToSuperview().inset(15.5)
            $0.size.equalTo(16)
        }
        
        addressLabel.snp.makeConstraints {
            $0.leading.equalTo(locationIconImage.snp.trailing).offset(4)
            $0.verticalEdges.equalToSuperview().inset(15)
            $0.width.equalTo(179)
            $0.height.equalTo(17)
        }
        
        searchKeywordButton.snp.makeConstraints {
            $0.top.equalTo(addressView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(15)
            $0.width.equalTo(self.view.snp.width).dividedBy(2).inset(10)
            $0.height.equalTo(50)
        }
        
        searchAddressButton.snp.makeConstraints {
            $0.top.equalTo(addressView.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(15)
            $0.width.equalTo(self.view.snp.width).dividedBy(2).inset(10)
            $0.height.equalTo(50)
        }
        
        selectButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(32)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(50)
            $0.width.equalTo(343)
        }
    }
    
    private func setupNavigationBar() {
        let customNavigationItem = CustomNavigationItem()
        customNavigationItem.setUpNavigationBar(for: .back)
        navigationItem.backBarButtonItem = customNavigationItem.backBarButtonItem
        navigationItem.backBarButtonItem?.tintColor = .gray1
        navigationItem.title = "주소 입력"
    }
    
    
    @objc private func searchKeywordButtonTapped() {
        print("키워드 검색 버튼이 눌렸습니다.")
    }
    
    @objc private func searchAddressButtonTapped() {
        print("주소 검색 버튼이 눌렸습니다.")
    }
    
    @objc private func selectButtonTapped() {
        let selectedAddress = addressLabel.text ?? "서울특별시 마포구 땡땡12로 3"
        delegate?.didSelectAddress(selectedAddress)
        navigationController?.popViewController(animated: true)
    }
    
}
