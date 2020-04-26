//
//  ApiFunc.swift
//  Wan
//
//  Created by Yang on 2020/4/20.
//  Copyright © 2020 Xinzy. All rights reserved.
//

enum RequestResult<T> {
    case success(_ result: T)
    case failure(_ message: String)
}

typealias RequestCallback<T> = (_ result: RequestResult<T>) -> Void

fileprivate func httpGet<T>(_ url: String, _ type: T.Type, _ callback: @escaping RequestCallback<T>) {
    AF.request(url).responseString { response in
        switch response.result {
        case let .success(content):
            if let result = JSONDeserializer<ApiResult<T>>.deserializeFrom(json: content) {
                if result.isSuccess {
                    callback(.success(result.data))
                } else {
                    callback(.failure(result.errorMsg))
                }
            } else {
                callback(.failure("解析JSON失败"))
            }
        case let .failure(error):
            xPrint(error)
            callback(.failure("网络错误"))
        }
    }
}

protocol HttpApiProtocol { }

// MARK: 首页
extension HttpApiProtocol {
    
    /// 首页Banner
    static func loadHomeBanner(_ callback: @escaping RequestCallback<[Banner]>) {
        httpGet(homeBannerUrl, [Banner].self, callback)
    }
    
    /// 首页置顶文章
    static func loadHomeTopArticles(_ callback: @escaping RequestCallback<[Article]>) {
        httpGet(topArticleUrl, [Article].self, callback)
    }
    
    /// 首页文章列表
    static func loadHomeArticles(_ page: Int, _ callback: @escaping RequestCallback<List<Article>>) {
        httpGet(homeArticleUrl(page), List<Article>.self, callback)
    }
    
}

//MARK: - 微信公众号
extension HttpApiProtocol {
    
    /// 微信公众号列表
    static func loadWechats(_ callback: @escaping RequestCallback<[Chapter]>) {
        httpGet(wxCategoryUrl, [Chapter].self, callback)
    }
    
    /// 微信公众号 文章列表
    static func loadWechatArticles(_ page: Int, _ id: Int, _ callback: @escaping RequestCallback<List<Article>>) {
        let url = wxArticleUrl(id, page)
        httpGet(url, List<Article>.self, callback)
    }
}

//MARK: - 项目
extension HttpApiProtocol {

    /// 项目分类列表
    static func loadProjectChapter(_ callback: @escaping RequestCallback<[Chapter]>) {
        httpGet(projectCategoryUrl, [Chapter].self, callback)
    }
    
    /// 项目列表
    static func loadProjectArticles(_ cid: Int, _ page: Int, _ callback: @escaping RequestCallback<List<Article>>) {
        let url = projectArticleUrl(cid, page)
        httpGet(url, List<Article>.self, callback)
    }
}

//MARK: - 知识体系
extension HttpApiProtocol {
    
    /// 获取知识体系分类列表
    static func loadKnowledgeChapter(_ callback: @escaping RequestCallback<[Chapter]>) {
        httpGet(systemCategoryURl, [Chapter].self, callback)
    }
}
