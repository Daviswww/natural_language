import Flutter
import UIKit
import NaturalLanguage
import os


@available(iOS 14.0, *)
public class NaturalLanguagePlugin: NSObject, FlutterPlugin {
  let recognizer = NLLanguageRecognizer()
  let encoder = JSONEncoder()
  let logger = Logger()
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "natural_language", binaryMessenger: registrar.messenger())
    let instance = NaturalLanguagePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
  
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let args = call.arguments as? [String: Any]
    print("Arguments::\(String(describing: args))")
    switch call.method {
    case "getDominantLanguage":
      if args != nil {
        let text = args?["text"] as? String ?? ""
        let response = getDominantLanguage(text: text)
        result(response)
      }else{
        result(FlutterMethodNotImplemented)
      }
    case "getLanguageHypotheses":
      if args != nil {
        let text = args?["text"] as? String ?? ""
        let withMaximum = args?["withMaximum"] as? Int ?? 3
        let response = getLanguageHypotheses(text: text, withMaximum: withMaximum)
        result(response)
      }else{
        result(FlutterMethodNotImplemented)
      }
      break
    case "isEnglish":
      if args != nil {
        let text = args?["text"] as? String ?? ""
        let threshold = args?["threshold"] as? Double ?? 0.9
        let response = isEnglish(text: text, threshold: threshold)
        result(response)
      }else{
        result(false)
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
  
  public func getDominantLanguage(text: String) -> String? {
    recognizer.reset()
    recognizer.processString(text)
    
    let lang = recognizer.dominantLanguage
    
    return lang?.rawValue
  }
  
  public func getLanguageHypotheses(text: String, withMaximum: Int) -> String? {
    
    var langs:[String:Double] = [:]
    recognizer.reset()
    recognizer.processString(text)
    let lang = recognizer.languageHypotheses(withMaximum: 3)
    
    lang.forEach { (key: NLLanguage, value: Double) in
      langs[key.rawValue] = value
    }
    
    if let jsonData = try? encoder.encode(langs) {
      if let jsonString = String(data: jsonData, encoding: .utf8) {
        return jsonString
      }
    }
    logger.log("\(langs.description)")
    return "{}"
  }
  
  public func isEnglish(text: String, threshold: Double)-> Bool {
    recognizer.reset()
    recognizer.processString(text)
    let lang = recognizer.languageHypotheses(withMaximum: 1)
    let isEn = lang.first { (key: NLLanguage, value: Double) in
      return key == NLLanguage.english && value > threshold
    }
    
    return (isEn != nil)
  }
  
  public func processString(text: String) -> Void {
    recognizer.processString(text)
    return
  }
  
  public func dominantLanguage(text: String) -> String? {
    let lang = recognizer.dominantLanguage
    
    return lang?.rawValue
  }
  
  public func languageHypotheses(text: String) -> String? {
    let lang = recognizer.languageHypotheses(withMaximum: 3)
    var langs:[String:Double] = [:]
    lang.forEach { (key: NLLanguage, value: Double) in
      langs[key.rawValue] = value
    }
    logger.log("\(langs.description)")
    return "{}"
  }
  
  public func reset(text: String) -> Void {
    recognizer.reset()
    return
  }
}
