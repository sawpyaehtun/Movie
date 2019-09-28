//
//  BookMarkViewModel.swift
//  Movie
//
//  Created by saw pyaehtun on 28/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class BookMarkViewModel : BaseViewModel {
    
    var bookmarkList = BehaviorRelay<[BookMarkVO]>(value: [])
    
    func getBookMarkList(success : @escaping () -> Void) {
        BookmarkModel.shared.getBookmarkList { (bookmarkVOs) in
            self.bookmarkList.accept(bookmarkVOs)
            success()
        }
    }
    
}
