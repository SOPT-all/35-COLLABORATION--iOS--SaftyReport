//
//  GalleryViewController.swift
//  saftyReport
//
//  Created by 이지훈 on 11/18/24.
//

import UIKit

import SnapKit
import Then
import Kingfisher

class GalleryViewController: UIViewController {
    
    private var baseView: UICollectionView!
    private var datasource: UICollectionViewDiffableDataSource<GallerySection, GalleryItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    private func setUI() {
        view.addSubview(baseView)
    }
    
    private func setLayout() {
        baseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    
    
}

//#Preview { GalleryViewController() }
