//
//  CollectionExtension.swift
//  MathSample
//
//  Created by Ajiaco on 2019/11/13.
//  Copyright © 2019 Ajiaco. All rights reserved.
//

// https://stackoverflow.com/questions/37222811/how-do-i-catch-index-out-of-range-in-swift

import UIKit

class CollectionExtension: UICollectionViewController {
    
    let items = [""]
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Items", for: indexPath)
        cell.backgroundColor = [.lightGray, .gray, .darkGray][indexPath.row%3]
        cell.titleLabel.text = items[exist: indexPath.item]
        
        return cell
    }
}



// MARK: - 테이블, 콜렉션의 OUT OF BOUNDS EXCEPTION 방어

extension Collection where Indices.Iterator.Element == Index { 
    
    subscript (exist index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
