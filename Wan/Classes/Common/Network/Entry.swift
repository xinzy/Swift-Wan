//
//  Entry.swift
//  Wan
//
//  Created by Yang on 2020/4/20.
//  Copyright © 2020 Xinzy. All rights reserved.
//

import UIKit

//MARK: - ApiResult
/// ApiResult
struct ApiResult<T>: HandyJSON {
    var data: T! = nil
    var errorCode: Int = 0
    var errorMsg: String = ""
    
    var isSuccess: Bool {
        errorCode == 0
    }
}

//MARK: - 首页Banner
/// 首页Banner
struct Banner: HandyJSON {
    var id: Int = 0
    var desc: String = ""
    var imagePath: String = ""
    var title: String = ""
    var url: String = ""
    var isVisible: Int = 0
    var order: Int = 0
    var type: Int = 0
}

//MARK: - 分类
/// 分类
struct Chapter: HandyJSON {
    var id: Int = 0
    var parentChapterId: Int = 0
    var courseId: Int = 0
    var order: Int = 0
    var visible: Int = 0
    var name: String = ""
    var children: [Chapter] = [Chapter]()
    
    var childrenNames: [String] {
        var names = [String]()
        children.forEach {
            names.append($0.name)
        }
        return names
    }
    
    var displayName: String {
        name.replaceAll(["&amp;" : "&"])
    }
}

//MARK: - 文章
/// 文章
struct Article: HandyJSON {
    var id: Int = 0
    var title: String = ""
    var chapterId: Int = 0
    var chapterName: String = ""
    var superChapterId: Int = 0
    var superChapterName: String = ""
    var author: String = ""
    var canEdit: Bool = false
    var collect: Bool = false
    var desc: String = ""
    var link: String = ""
    var publishTime: Int = 0
    var envelopePic: String = ""
    
    var fresh: Bool = false
    var type: Int = 0
    var userId: Int = 0
    var visible: Int = 0
    var zan: Int = 0
    
    var displayTitle: String {
        let dict = [
            "&ldquo;" : "“",
            "&rdquo;" : "”",
            "&mdash;" : "-",
            "&nbsp;" : " ",
            "&quot;":"\"",
            "&lt;" : "<",
            "&gt;" : ">",
            "&amp;" : "&",
            "&apos;" : "'",
            "&cent;" : "￠",
            "&pound;" : "£",
            "&yen;" : "¥",
            "&euro;" : "€",
            "&#167;" : "§",
            "&copy;" : "©",
            "&reg;" : "®",
            "&trade;" : "™",
            "&times;" : "×",
            "&divide;" : "÷",
        ]
        return title.replaceAll(dict)
    }
    
    var displayAuthor: String {
        author.isEmpty ? "匿名" : author
    }
    
    /// 是否置顶文章
    var top: Bool {
        type == 1
    }
    
    var category: String {
        superChapterName + " / " + chapterName
    }
    
    var displayTime: String {
        formatTime(millisecond: publishTime)
    }
}

//MARK: - List
/// 列表
struct List<T: HandyJSON>: HandyJSON{
    var curPage: Int = 0
    var offset: Int = 0
    var over: Bool = false
    var pageCount: Int = 0
    var size: Int = 0
    var total: Int = 0
    
    var datas: [T] = [T]()
}

//MARK: - 用户
struct User: HandyJSON {
    var id: Int = 0
    var nickname: String = ""
    var publicName: String = ""
    var username: String = ""
    var email: String = ""
    var token: String = ""
    var icon: String = ""
    var type: Int = 0
    var admin: Bool = false
    
    var collectIds: [Int] = [Int]()
    
    var favorCount: Int {
        collectIds.count
    }
    
    var isLogin: Bool {
        id != 0
    }
    static var me: User = User()
    
    private static let KEY_LOGIN_ID = "LoginId"
    private static let KEY_LOGIN_USERNAME = "LoginUsername"
    private static let KEY_LOGIN_NICKNAME = "LoginNickname"
    
    static func autoLogin() {
        let id = UserDefaults.standard.integer(forKey: User.KEY_LOGIN_ID)
        guard id > 0 else { return }
        
        User.me.id = id
        User.me.username = UserDefaults.standard.string(forKey: User.KEY_LOGIN_USERNAME) ?? ""
        User.me.nickname = UserDefaults.standard.string(forKey: KEY_LOGIN_USERNAME) ?? ""
    }
    
    mutating func login(_ user: User) {
        self.id = user.id
        self.username = user.username
        self.nickname = user.nickname
        
        UserDefaults.standard.set(user.id, forKey: User.KEY_LOGIN_ID)
        UserDefaults.standard.set(user.username, forKey: User.KEY_LOGIN_USERNAME)
        UserDefaults.standard.set(user.nickname, forKey: User.KEY_LOGIN_NICKNAME)
    }
    
    mutating func logout() {
        self.id = 0
        self.username = ""
        self.nickname = ""
        
        UserDefaults.standard.set(0, forKey: User.KEY_LOGIN_ID)
        UserDefaults.standard.set("", forKey: User.KEY_LOGIN_USERNAME)
        UserDefaults.standard.set("", forKey: User.KEY_LOGIN_NICKNAME)
    }
}

/// 导航数据
struct Navi: HandyJSON {
    var cid: Int = 0
    var name: String = ""
    var articles: [Article] = [Article]()
}
