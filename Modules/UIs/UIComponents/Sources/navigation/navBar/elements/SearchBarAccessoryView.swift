//
//  SearchBarAccessoryView.swift
//  UIComponents
//
//  Created by Alexander Ivlev on 10/10/2019.
//  Copyright © 2019 ApostleLife. All rights reserved.
//


import UIKit

public final class SearchBarAccessoryView: UIView, INavigationBarAccessoryView {
    public let fullyHeight: CGFloat = 50.0
    public let canHidden: Bool = true

    private let searchBar: UISearchBar = UISearchBar(frame: .zero)

    public init() {
        super.init(frame: .zero)

        addSubview(searchBar)
        clipsToBounds = true

        searchBar.barStyle = .default
        searchBar.isTranslucent = true
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = .red

        let color = UIColor.blue.withAlphaComponent(0.2)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = color
        //searchBar.setSearchFieldBackgroundImage(UIImage(), for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func recalculateViews(for t: CGFloat) {
        searchBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: fullyHeight)
        searchBar.endEditing(true)
    }
}

