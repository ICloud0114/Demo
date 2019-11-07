//
//  WebViewController.swift
//
//  Created by Topband on 2018/11/23.
//

import UIKit
import WebKit


fileprivate func web404NotFoundHTMLPath() -> String? {
    return ""//publicComponent_bundle()?.path(forResource: "html.bundle/404", ofType: "html")
}

fileprivate func webNetErrorHTMLPath() -> String? {
    return ""//publicComponent_bundle()?.path(forResource: "html.bundle/neterror", ofType: "html")
}

/// URL key for 404 not found page.
fileprivate let web404NotFoundURLKey = "ax_404_not_found"

/// URL key for network error page.
fileprivate let webNetworkErrorURLKey = "ax_network_error"

open class WebViewController: UIViewController {

    public enum WebViewControllerError: Error {
        case urlNil 
    }
    
    //MARK: Public Property
    //超时时间
    public var timeoutInternal: TimeInterval = 30 {
        didSet {
            if var request = _request {
                request.timeoutInterval = timeoutInternal
                _navigation = webView.load(request)
                _request = request
            }
        }
    }
    
    //允许title最大z长度
    public var maxAllowedTitleLength: UInt = 10 {
        didSet {
            updateWebControllerTitle()
        }
    }
    
    //缓存策略
    public var cachePolicy: URLRequest.CachePolicy = .reloadRevalidatingCacheData {
        didSet {
            if var request = _request {
                request.cachePolicy = cachePolicy
                _navigation = webView.load(request)
                _request = request
            }
        }
    }
    // 是否显示tabbar
    public var isShowTabbar: Bool = false {
        didSet {
            adaptiveWebView()
        }
    }
    
    public var isShowNavigation: Bool = true {
        didSet {
             adaptiveWebView()
        }
    }
        
    public lazy var webView: WKWebView = {
        var config: WKWebViewConfiguration! = _configuration
        if _configuration == nil {
            config = WKWebViewConfiguration()
            config.preferences.minimumFontSize = 9.0
            config.allowsInlineMediaPlayback = true
            if #available(iOS 9.0, *) {
                config.applicationNameForUserAgent = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
            }
            if #available(iOS 10.0, *) {
                config.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypes(rawValue: 0)
            } else if #available(iOS 9.0, *) {
                config.requiresUserActionForMediaPlayback = false
            } else {
                config.mediaPlaybackRequiresUserAction = false
            }
        }
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.allowsBackForwardNavigationGestures = true
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        webView.translatesAutoresizingMaskIntoConstraints = false
//        webView.addObserver(self, forKeyPath: "scrollView.contentOffset", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
//        if #available(iOS 11.0, *) {
//            webView.scrollView.contentInsetAdjustmentBehavior = .never
//        } else {
//            automaticallyAdjustsScrollViewInsets = false
//        }
        return webView
    }()
    
    //MARK: Internal UI Property
    fileprivate lazy var _progressView: WebViewControllerProgressView = {
        let navigationBarBounds = navigationController?.navigationBar.bounds ?? CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 2)
        let frame = CGRect(x: 0, y: navigationBarBounds.height - 2, width: navigationBarBounds.width, height: 2)
        let progress = WebViewControllerProgressView(frame: frame)
        progress.trackTintColor = .clear
        progress.backgroundColor = .clear
        progress.progressTintColor = navigationController?.navigationBar.tintColor
        progress.autoresizingMask = [.flexibleWidth, .flexibleTopMargin] 
        progress.progress = 0.0
        return progress
    }()
    
    fileprivate lazy var _layoutGuide: UILayoutGuide = {
        var layoutGuide: UILayoutGuide!
        if #available(iOS 11.0, *) {
            layoutGuide = view.safeAreaLayoutGuide
        } else {
            // Fallback on earlier versions
            layoutGuide = UILayoutGuide()
            view.addLayoutGuide(layoutGuide)
            layoutGuide.topAnchor.constraint(equalTo: view.topAnchor, constant:0).isActive = true
            layoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
            layoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
            layoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        }
        return layoutGuide
    }()
    
    fileprivate var _navigation: WKNavigation?
    
    //MARK: Internal NoUi Property
    fileprivate var _url: URL?
    fileprivate var _request: URLRequest?
    fileprivate var _configuration: WKWebViewConfiguration?
    fileprivate var _htmlString: String?
    fileprivate var _baseUrl: URL?
    
    //MARK: Life Cycle
    public init(url: URL?) {
        super.init(nibName: nil, bundle: nil)
        _url = url
        initializer()
    }
    
    public init(request: URLRequest) {
        super.init(nibName: nil, bundle: nil)
        _request = request
        initializer()
    }
    
    public init(htmlString: String, baseUrl: URL?) {
        super.init(nibName: nil, bundle: nil)
        _htmlString = htmlString
        _baseUrl = baseUrl
        initializer()
    }
    
    public convenience init(address urlString: String) throws {
        guard let url = URL(string: urlString) else {
            throw WebViewControllerError.urlNil
        }
        self.init(url: url)
    }
    
    public convenience init(url: URL, configuration: WKWebViewConfiguration) {
        self.init(url: url)
        _configuration = configuration
    }
    
    public convenience init(request: URLRequest, configuration: WKWebViewConfiguration) {
        self.init(request: request)
        _configuration = configuration
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initializer() {
        
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSubViews()
        
        if let req = _request {
            load(req)
        } else if let url = _url {
            load(url)
        } else if let htmlString = _htmlString {
            loadHTMLString(htmlString, baseURL: _baseUrl)
        } else { //无页面
            if self.isMember(of: WebViewController.self)  { //如果子类化当前类，则不载入404页面
                load(URL(fileURLWithPath: web404NotFoundHTMLPath()!))
            }
        }
        
        view.backgroundColor = .white//UIColor(red: 0.180, green: 0.192, blue: 0.196, alpha: 1.00)
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if navigationController != nil {
            updateFrameOfProgressView()
            navigationController?.navigationBar.addSubview(_progressView)
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if navigationController != nil {
            _progressView.removeFromSuperview()
        }
    }
    
    deinit {
        webView.stopLoading()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        webView.uiDelegate = nil
        webView.navigationDelegate = nil
//        webView.removeObserver(self, forKeyPath: "scrollView.contentOffset")
        webView.removeObserver(self, forKeyPath: "title")
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    //MARK: Public Method
    public func load404Page() {
        load(URL(fileURLWithPath: web404NotFoundHTMLPath()!))
    }
    
    public func loadNetErrorPage() {
        load(URL(fileURLWithPath: webNetErrorHTMLPath()!))
    }
    
    public func load(_ url: URL) {
        let request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInternal)
        _request = request
        load(request)
    }
    
    public func loadHTMLString(_ string: String, baseURL: URL?) {
        _baseUrl = baseURL
        _htmlString = string
        _navigation = webView.loadHTMLString(string, baseURL: baseURL)
    }
    
    //MARK: Pulgin 
    // web载入的url为空
    open func webNotFoundUrl() {
        
    }
    
    //MARK: Public Method 子类可重写(重写时必须先调用父类方法)
    open func webDidStartLoad(_ navigation: WKNavigation) {
        self.navigationItem.title = "载入中..."
    }
    
    open func webDidFinishLoad() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        updateWebControllerTitle()
    }
    
    open func webDidFailLoad(_ error: NSError) {
        if error.code == NSURLErrorCannotFindHost { //404
            load(URL(fileURLWithPath: web404NotFoundHTMLPath()!))
        } else {
            load(URL(fileURLWithPath: webNetErrorHTMLPath()!))
        }
        
        self.navigationItem.title = "加载失败"
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        _progressView.setProgress(0.9, animated: true)
    }
    
    //MARK: Internal helper function
    fileprivate func setupSubViews() {
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        webView.topAnchor.constraint(equalTo: _layoutGuide.topAnchor, constant: 0).isActive = true
        webView.leadingAnchor.constraint(equalTo: _layoutGuide.leadingAnchor, constant: 0).isActive = true
        webView.trailingAnchor.constraint(equalTo: _layoutGuide.trailingAnchor, constant: 0).isActive = true
        webView.bottomAnchor.constraint(equalTo: _layoutGuide.bottomAnchor, constant: 0).isActive = true
        
//        adaptiveWebView()
        
        view.addSubview(_progressView)
    }
    
    fileprivate func adaptiveWebView() {
        if webView.superview == nil {
            return
        }
        
//        if #available(iOS 11.0, *) {
//            webView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: isShowTabbar ? UIAdaptive.tabbarHeight : UIAdaptive.noTabbarHeight, right: 0)
//            webView.scrollView.scrollIndicatorInsets = webView.scrollView.contentInset
//        } else {
//            webView.scrollView.contentInset = UIEdgeInsets(top: isShowNavigation ? UIAdaptive.navigationBarHeight : UIAdaptive.noTabbarHeight, left: 0, bottom: isShowTabbar ? UIAdaptive.tabbarHeight : UIAdaptive.noTabbarHeight, right: 0)
//            webView.scrollView.scrollIndicatorInsets = webView.scrollView.contentInset
//        }
    }
    
    fileprivate func updateFrameOfProgressView() {
        let navigationBarBounds = navigationController?.navigationBar.bounds ?? CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 2)
        let frame = CGRect(x: 0, y: navigationBarBounds.height - 2, width: navigationBarBounds.width, height: 2)
        _progressView.frame = frame
    }
    
    fileprivate func load(_ urlRequest: URLRequest) {
        _navigation = webView.load(urlRequest)
    }
    
    fileprivate func updateWebControllerTitle() {
        var title: String?
        if let _title = self.title, _title.count > 0 {
            title = _title
        } else {
            title = webView.title
        }
        if let _title = title, _title.count > maxAllowedTitleLength {
            title = String(_title.prefix(Int(maxAllowedTitleLength))) + "..."
        }
        
        navigationItem.title = title ?? "网页浏览"
    }
    
    //MARK: KVO
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let keyPath = keyPath else { return }
        if keyPath == "estimatedProgress" {
            if let navigationController = navigationController, let progressViewSuperView = _progressView.superview, navigationController.navigationBar != progressViewSuperView {
                updateFrameOfProgressView()
                navigationController.navigationBar.addSubview(_progressView)
            }
            guard let progressNumber = change?[NSKeyValueChangeKey.newKey] as? NSNumber else {
                return
            }
            let progress = progressNumber.floatValue
            if progress >= _progressView.progress {
                _progressView.setProgress(progress, animated: true)
            } else {
                _progressView.setProgress(progress, animated: false)
            }
        } else if keyPath == "title" {
            updateWebControllerTitle()
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}

//MARK: WKUIDelegate
extension WebViewController: WKUIDelegate {
    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if let frameInfo = navigationAction.targetFrame {
            if !frameInfo.isMainFrame {
                webView.load(navigationAction.request)
            }
        }
        return nil
    }
    
    public func webViewDidClose(_ webView: WKWebView) {
        
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
    }
}

//MARK: WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {
    
    //决策当前请求是否允许跳转,可做url拦截
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let absoluteString = navigationAction.request.url?.absoluteString, let components = URLComponents(string: absoluteString) else {
            decisionHandler(.cancel)
            return
        }

        // URL actions for 404 and Errors:
        if NSPredicate(format: "SELF ENDSWITH[cd] %@ OR SELF ENDSWITH[cd] %@", web404NotFoundURLKey, webNetworkErrorURLKey).evaluate(with: components.url?.absoluteString) {
            if let pUrl = _url {
                load(pUrl)
            } else {
                webNotFoundUrl()
            }
        }
        
        decisionHandler(.allow)
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    //开始加载
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        webDidStartLoad(navigation)
    }
    
    //重定向
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        if (error as NSError).code == NSURLErrorCancelled {
            return;
        }
        webDidFailLoad(error as NSError)
    }
    
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    //完成加载
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webDidFinishLoad()
    }
    
    //加载失败
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        if (error as NSError).code == NSURLErrorCancelled {
            return;
        }
        webDidFailLoad(error as NSError)
    }
       
    //网页证书认证
    public func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if let serverTrust = challenge.protectionSpace.serverTrust {
                let credntial = URLCredential(trust: serverTrust)
                completionHandler(.useCredential,credntial)
                return
            }
        }
        completionHandler(.performDefaultHandling, nil)
    }
    
    //网页进程终止
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        
    }
}

class WebViewControllerProgressView: UIProgressView {
    
    override var progress: Float {
        set {
            super.progress = newValue
            checkIsHiddenWhenProgressApproachFullSize()
        }
        get {
            return super.progress
        }
    }
    
    override func setProgress(_ progress: Float, animated: Bool) {
        super.setProgress(progress, animated: animated)
        checkIsHiddenWhenProgressApproachFullSize()
    }
    
    func checkIsHiddenWhenProgressApproachFullSize() {
        if progress < 1 {
            if self.isHidden {
                self.isHidden = false
            }
        } else if progress >= 1 {
            UIView.animate(withDuration: 0.35, delay: 0.15, options: UIView.AnimationOptions(rawValue: 7), animations: { 
                self.alpha = 0
            }, completion: { finished in
                if finished {
                    self.alpha = 1.0
                    self.progress = 0.0
                    self.isHidden = true
                }
            })
        }
    }
}
