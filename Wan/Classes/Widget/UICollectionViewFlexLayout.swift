//
//  UICollectionViewFlexLayout.swift
//  Wan
//
//  Created by Yang on 2020/4/26.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

class UICollectionViewFlexLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

       guard let originalAttributes = super.layoutAttributesForElements(in: rect) else { return nil  }

       var updatedAttributes = originalAttributes

       for attributes in updatedAttributes {
           guard attributes.representedElementKind == nil else { continue  }
           guard let index = updatedAttributes.firstIndex(of: attributes) else { continue  }
        
           if let attr = layoutAttributesForItem(at: attributes.indexPath) {
               updatedAttributes[index] = attr
           }
       }
       return updatedAttributes
   }
   
   override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {

       guard let currentItemAttributes = super.layoutAttributesForItem(at: indexPath) else { return nil }

       let sectionInset = evaluatedSectionInsetForItem(at: indexPath.section)
       let isFirstItemInSection = indexPath.item == 0
       let layoutWidth = collectionView!.frame.width - sectionInset.left - sectionInset.right

       if isFirstItemInSection {
        currentItemAttributes.frame.left = sectionInset.left //.leftAlignFrameWithSectionInset(sectionInset)
           return currentItemAttributes
       }

       let previousIndexPath = IndexPath(row: indexPath.item - 1, section: indexPath.section)
       
       let previousFrame = layoutAttributesForItem(at: previousIndexPath)?.frame ?? .zero
       let previousFrameRightPoint = previousFrame.minX + previousFrame.width
       let currentFrame = currentItemAttributes.frame
       let strecthedCurrentFrame = CGRect(x: sectionInset.left, y: currentFrame.minY, width: layoutWidth, height: currentFrame.height)
       // if the current frame, once left aligned to the left and stretched to the full collection view
       // widht intersects the previous frame then they are on the same line
       let isFirstItemInRow = !previousFrame.intersects(strecthedCurrentFrame)
       
       if isFirstItemInRow {
           // make sure the first item on a line is left aligned
            currentItemAttributes.frame.left = sectionInset.left
           return currentItemAttributes
       }

       currentItemAttributes.frame.origin.x = previousFrameRightPoint + evaluatedMinimumInteritemSpacing(at: indexPath.section)
       return currentItemAttributes
   }
   
   func evaluatedMinimumInteritemSpacing(at sectionIndex:Int) -> CGFloat {
       if let delegate = self.collectionView?.delegate as? UICollectionViewDelegateFlowLayout {
           let inteitemSpacing = delegate.collectionView?(self.collectionView!, layout: self, minimumInteritemSpacingForSectionAt: sectionIndex)
           if let inteitemSpacing = inteitemSpacing {
               return inteitemSpacing
           }
       }
       return minimumInteritemSpacing
   }

   func evaluatedSectionInsetForItem(at index: Int) -> UIEdgeInsets {
       if let delegate = collectionView?.delegate as? UICollectionViewDelegateFlowLayout {
           let insetForSection = delegate.collectionView?(collectionView!, layout: self, insetForSectionAt: index)
           if let insetForSectionAt = insetForSection {
               return insetForSectionAt
           }
       }
       return sectionInset
   }
}
