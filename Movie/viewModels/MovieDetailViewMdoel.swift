//
//  MovieDetailViewMdoel.swift
//  Movie
//
//  Created by saw pyaehtun on 28/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation

class MovieDetailViewModel: BaseViewModel {

    func getBookMarkIDList(success : @escaping ([Int]) -> Void) {
        BookmarkModel.shared.getBookmarkList { (bookMarkVOs) in
            var bookmarkIDLsit : [Int] = []
            bookMarkVOs.forEach { (bookMarkVO) in
                bookmarkIDLsit.append(bookMarkVO.id!)
            }
            success(bookmarkIDLsit)
        }
    }
    
    func addToBookMark(bookmarkVO : BookMarkVO,success :  @escaping () -> Void) {
        BookmarkModel.shared.addToCoreData(bookmarkVO: bookmarkVO)
        success()
    }
    
    func deleteFromBookMark(id : Int,success :  @escaping () -> Void) {
        BookmarkModel.shared.deleBookMarkById(id: id) {
            success()
        }
    }
}
