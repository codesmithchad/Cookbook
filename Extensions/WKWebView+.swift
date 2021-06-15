import UIKit
import WebKit

extension WKWebView {
    static func setCookie(name: String?,
                          value: String?,
                          domain: String = ".conects.com",
                          path: String = "/",
                          version: String = "1",
                          expires: Date? = nil,
                          webView: WKWebView? = nil) {
        var cookie = [HTTPCookiePropertyKey: Any]()
        var expiresString: String? = expires?.description
        if nil == expiresString {
            expiresString = "2100-01-01 00:00:00 +0000"
            let dayOffset = DateComponents(year: 1)
            if let afterOneYear = NSCalendar.current.date(byAdding: dayOffset, to: Date()) {
                expiresString = afterOneYear.toStringKST(dateFormat: "yyyy-MM-dd HH:mm:ss")
            }
        }
        cookie[.name] = name
        cookie[.value] = value
        cookie[.domain] = domain
        cookie[.path] = path
        cookie[.version] = version
        cookie[.expires] = expiresString
        guard let newCookie = HTTPCookie(properties: cookie) else { return }
        WKWebsiteDataStore.default().httpCookieStore.setCookie(newCookie, completionHandler: nil)
        guard let webView = webView else { return }
        webView.configuration.websiteDataStore.httpCookieStore.setCookie(newCookie, completionHandler: nil)

    }
    static func printCookie(_ webView: WKWebView?) {
        printCookieDataStore(WKWebsiteDataStore.default().httpCookieStore, header: "WKWebsiteDataStore")
        guard let webView = webView else { return }
        printCookieDataStore(webView.configuration.websiteDataStore.httpCookieStore,
                             header: "webView [\(String(describing: webView.url?.absoluteString))]")
    }

    static func printCookieDataStore(_ dataStore: WKHTTPCookieStore, header: String) {
        dataStore.getAllCookies { result in
            var logString: String = ""
            logString += "\(header) result [\(result.count)개] Start ************"
            for newCookie in result {
                logString += "\n\tcookie name[\(newCookie.name)]" +
                    " value[\(newCookie.value)]" +
                    " domain[\(newCookie.domain)]" +
                    " path[\(newCookie.path)]" +
                    " version[\(newCookie.version)]" +
                    " expires[\(String(describing: newCookie.expiresDate))]"
            }
            logString += "\n\(header) result [\(result.count)개] End ***********"
            printLog("printCookieDataStore [\n\(logString)\n]")
        }
    }
}
