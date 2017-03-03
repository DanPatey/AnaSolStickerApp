//
//  StickerCollectionViewController.swift
//  AnaSolStickerApp
//
//  Created by Dan Patey on 3/3/17.
//  Copyright © 2017 Dan Patey. All rights reserved.
//

import UIKit
import Messages

let stickerNameGroups: [String: [String]] = [
    "Healthy": ["Ginger", "Lemon", "Melon", "Orange", "Strawberry"],
    "Delicous": ["Banana", "Kiwi", "Pineapple"],
    "Antioxidents": ["ChocolateBanana", "ChocolateMelon", "ChocolatePineapple", "ChocolateStrawberry"]
]

struct StickerGroup {
    let name: String
    let members: [MSSticker]
}

class StickerCollectionViewController: UICollectionViewController {
    var stickerGroups = [StickerGroup]()
}

extension StickerCollectionViewController {
    // 1
    func loadStickers(_ chocoholic: Bool = false) {
        // 2
        stickerGroups = stickerNameGroups.filter({ (name, _) in
            // 3
            return chocoholic ? name == "Chocolate" : true
            }).map { (name, stickerNames) in
            // 4
            let stickers: [MSSticker] = stickerNames.map { name in
                let url = Bundle.main.url(forResource: name, withExtension: "png")!
                return try! MSSticker(contentsOfFileURL: url, localizedDescription: name)
            }
            // 5
                return StickerGroup(name: name, members: stickers)
        }
        // 6
        stickerGroups.sort(by: { $0.name < $1.name })
    }
}
