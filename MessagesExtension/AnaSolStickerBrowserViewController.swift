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
        stickerBrowserView.backgroundColor = #colorLiteral(
            red:  0.9490196078, green: 0.7568627451,
            blue: 0.8196078431, alpha: 1)
    }
    
}

extension AnaSolStickerBrowserViewController {
    
    func loadStickers(_ chocoholic: Bool = false) {
        stickers = stickerNames.filter( { name in
            return chocoholic ? name.contains("Chocolate") : true
        }).map({ name in
            let url = Bundle.main.url(forResource: name, withExtension: "png")!
            return try! MSSticker(contentsOfFileURL: url, localizedDescription: name)
        })
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
