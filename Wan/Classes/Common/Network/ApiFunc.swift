//
//  ApiFunc.swift
//  Wan
//
//  Created by Yang on 2020/4/20.
//  Copyright © 2020 Xinzy. All rights reserved.
//
import Alamofire

enum RequestResult<T> {
    case success(_ result: T)
    case failure(_ message: String)
}

typealias RequestCallback<T> = (_ result: RequestResult<T>) -> Void

fileprivate func httpRequest<T>(_ url: String, _ type: T.Type, method: HTTPMethod = .get, params: [String: String]? = nil, callback: @escaping RequestCallback<T>) {
    
    AF.request(url, method: method, parameters: params).responseString { response in
        
        switch response.result {
        case let .success(content):
            if let result = JSONDeserializer<ApiResult<T>>.deserializeFrom(json: content) {
                if result.isSuccess {
                    if let data = result.data {
                        callback(.success(data))
                    } else {
                        callback(.success(true as! T))
                    }
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
        httpRequest(homeBannerUrl, [Banner].self, callback: callback)
    }
    
    /// 首页置顶文章
    static func loadHomeTopArticles(_ callback: @escaping RequestCallback<[Article]>) {
        httpRequest(topArticleUrl, [Article].self, callback: callback)
    }
    
    /// 首页文章列表
    static func loadHomeArticles(_ page: Int, _ callback: @escaping RequestCallback<List<Article>>) {
        httpRequest(homeArticleUrl(page), List<Article>.self, callback: callback)
    }
    
}

//MARK: - 微信公众号
extension HttpApiProtocol {
    
    /// 微信公众号列表
    static func loadWechats(_ callback: @escaping RequestCallback<[Chapter]>) {
        httpRequest(wxCategoryUrl, [Chapter].self, callback: callback)
    }
    
    /// 微信公众号 文章列表
    static func loadWechatArticles(_ page: Int, _ id: Int, _ callback: @escaping RequestCallback<List<Article>>) {
        let url = wxArticleUrl(id, page)
        httpRequest(url, List<Article>.self, callback: callback)
    }
}

//MARK: - 项目
extension HttpApiProtocol {

    /// 项目分类列表
    static func loadProjectChapter(_ callback: @escaping RequestCallback<[Chapter]>) {
        httpRequest(projectCategoryUrl, [Chapter].self, callback: callback)
    }
    
    /// 项目列表
    static func loadProjectArticles(_ cid: Int, _ page: Int, _ callback: @escaping RequestCallback<List<Article>>) {
        let url = projectArticleUrl(cid, page)
        httpRequest(url, List<Article>.self, callback: callback)
    }
}

//MARK: - 知识体系
extension HttpApiProtocol {
    
    /// 获取知识体系分类列表
    static func loadKnowledgeChapter(_ callback: @escaping RequestCallback<[Chapter]>) {
        httpRequest(systemCategoryURl, [Chapter].self, callback: callback)
    }
    
    /// 知识体系下的文章列表
    static func loadKnowledgeArticles(_ id: Int, _ page: Int, _ callback: @escaping RequestCallback<List<Article>>) {
        let url = systemArticleUrl(id, page)
        httpRequest(url, List<Article>.self, callback: callback)
    }
}

//MARK: - 用户
extension HttpApiProtocol {
    
    /// 用户登录
    static func login(_ username: String, _ password: String, _ callback: @escaping RequestCallback<User>) {
        var params = [String : String]()
        params["username"] = username
        params["password"] = password
        httpRequest(loginUrl, User.self, method: .post, params: params, callback: callback)
    }
    
    /// 用户注册
    static func register(_ username: String, _ password: String, _ confirm: String, _ callback: @escaping RequestCallback<Any>) {
        var params = [String : String]()
        params["username"] = username
        params["password"] = password
        params["repassword"] = confirm
        
        httpRequest(registerUrl, Any.self, method: .post, params: params, callback: callback)
    }
    
    /// 退出登录
    static func logout(_ callback: @escaping RequestCallback<Any>) {
        httpRequest(logoutUrl, Any.self, callback: callback)
    }
}

//MARK: - 收藏
extension HttpApiProtocol {
    
    /// 收藏站内资源
    static func collectSelfArticle(_ id: Int, _ callback: @escaping RequestCallback<Any>) {
        let url = collectionSelfUrl(id)
        httpRequest(url, Any.self, method: .post, callback: callback)
    }
    
    /// 取消收藏站内资源
    static func uncollectSelfArticle(_ id: Int, _ callback: @escaping RequestCallback<Any>) {
        let url = uncollectionSelfUrl(id)
        httpRequest(url, Any.self, method: .post, callback: callback)
    }
}

//MARK: - 其他API
extension HttpApiProtocol {
    
    /// 导航数据
    static func loadNavi(_ callback: @escaping RequestCallback<[Navi]>) {
        httpRequest(navigationUrl, [Navi].self, callback: callback)
    }
}
