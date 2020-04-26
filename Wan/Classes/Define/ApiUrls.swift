//
//  ApiUrls.swift
//  Wan
//
//  Created by Yang on 2020/4/20.
//  Copyright © 2020 Xinzy. All rights reserved.
//

fileprivate let BASE_URL = "https://www.wanandroid.com"

//MARK: - 首页

fileprivate let HOME_ARTICLES = "\(BASE_URL)/article/list/%d/json"

/// 首页Banner
let homeBannerUrl = "\(BASE_URL)/banner/json"

/// 置顶文章
let topArticleUrl = "\(BASE_URL)/article/top/json"


/// 首页文章列表接口
func homeArticleUrl(_ page: Int) -> String {
    String(format: HOME_ARTICLES, page)
}

//MARK: - 公众号

/// 公众号列表
let wxCategoryUrl = "\(BASE_URL)/wxarticle/chapters/json"

/// 公众号文章列表
fileprivate let WX_ARTICLES = "\(BASE_URL)/wxarticle/list/%d/%d/json?k=%@"

/// 公众号文章列表
func wxArticleUrl(_ id: Int, _ page: Int, _ keyword: String = "") -> String {
    String(format: WX_ARTICLES, id, page, keyword)
}

//MARK: - 项目

/// 项目分类
let projectCategoryUrl = "\(BASE_URL)/project/tree/json"

/// 项目列表数据
fileprivate let PROJECT_ARTICLES = "\(BASE_URL)/project/list/%d/json?cid=%d"

/// 项目列表数据
func projectArticleUrl(_ id: Int, _ page: Int) -> String {
    String(format: PROJECT_ARTICLES, page, id)
}


// MARK: - 体系

/// 体系数据
let systemCategoryURl = "\(BASE_URL)/tree/json"

/// 知识体系下的文章
fileprivate let SYSTEM_ARTICLES = "\(BASE_URL)/article/list/%d/json?cid=%d"

/// 知识体系下的文章
func systemArticleUrl(_ id: Int, _ page: Int) -> String {
    String(format: SYSTEM_ARTICLES, page, id)
}


// MARK: - 用户

/// 登录
let loginUrl = "\(BASE_URL)/user/login"

/// 注册
let registerUrl = "\(BASE_URL)/user/register"

/// 退出
let logoutUrl = "\(BASE_URL)/user/logout/json"




// MARK: - 其他

/// 常用网站
let friendLinkUrl = "\(BASE_URL)/friend/json"

/// 搜索热词
let hotKeywordUrl = "\(BASE_URL)/hotkey/json"

/// 导航数据
let navigationUrl = "\(BASE_URL)/navi/json"

