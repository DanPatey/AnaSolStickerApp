//
//  AnaSolStickerBrowserViewController.swift
//  AnaSolStickerApp
//
//  Created by Dan Patey on 3/3/17.
//  Copyright © 2017 Dan Patey. All rights reserved.
//

import Messages

let stickerNames = ["ChocolateMelon", "ChocolateBanana", "ChocolatePineapple", "ChocolateStrawberry", "Ginger", "Kiwi", "Lemon", "Melon", "Banana", "Orange", "Pineapple", "Strawberry"]

class AnaSolStickerBrowserViewController: MSStickerBrowserViewController {
    
    var stickers = [MSSticker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStickers()
        if let layout = collectionView?.collectionViewLayout as?
            UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
        collectionView?.backgroundColor = #colorLiteral(
            red:  0.9490196078, green: 0.7568627451,
            blue: 0.8196078431, alpha: 1)
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension StickerCollectionViewController {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewFlowLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let edge = min(collectionView.bounds.width / 3, 136)
        return CGSize(width: edge, height: edge)
    }
}

extension AnaSolStickerBrowserViewController {
    
    func loadStickers(_ chocoholic: Bool = false) {
        stickers = stickerNames.filter( { name in
            return chocoholic ? name.contains("Chocolate") : true
        }).map({ name in
            let url = Bundle.main.url(forResource: name,
                                      withExtension: "png")!
            return try! MSSticker(contentsOfFileURL: url,
                                  localizedDescription: name)
        })
    }
}

extension StickerCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return stickerGroups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stickerGroups[section].members.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StickerCollectionViewCell", for: indexPath) as! StickerCollectionViewCell
        
        let sticker = stickerGroups[indexPath.section].members[indexPath.row]
        cell.stickerView.sticker = sticker
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionElementKindSectionHeader else {
            fatalError()
        }
        
        let header = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeader
        header.label.text = stickerGroups[indexPath.section].name
        return header
    }
}

extension StickerCollectionViewController: Chocoholicable {
    func setChocoholic(_ chocoholic: Bool) {
        loadStickers(chocoholic)
        collectionView?.reloadData()
    }
}

extension AnaSolStickerBrowserViewController: Chocoholicable {
    func setChocoholic(_ chocoholic: Bool) {
        loadStickers(chocoholic)
        stickerBrowserView.reloadData()
    }
}

//MARK: MSStickerBrowserViewDataSource
extension AnaSolStickerBrowserViewController {
    override func numberOfStickers(in stickerBrowserView: MSStickerBrowserView) -> Int {
        return stickers.count
    }
    
    override func stickerBrowserView(_ stickerBrowserView: MSStickerBrowserView, stickerAt index: Int) -> MSSticker {
        return stickers[index]
    }
}
