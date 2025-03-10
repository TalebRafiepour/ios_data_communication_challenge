import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
      let controller = window.rootViewController as! FlutterViewController
      let eventChannel = FlutterEventChannel(name: "com.example.test/timer_event", binaryMessenger: controller.binaryMessenger)
      
      eventChannel.setStreamHandler(TimerStreamHandler())
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

class TimerStreamHandler: NSObject, FlutterStreamHandler {
    
    private var eventSink: FlutterEventSink?
    private var timer: Timer?
    
    
    @objc private func sendTime() {
        if let eventSink = eventSink {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let formattedDate = dateFormatter.string(from: Date())
            eventSink(formattedDate)
        }
    }
    
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(sendTime), userInfo: nil, repeats: true)
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        timer?.invalidate()
        timer = nil
        eventSink = nil
        
        return nil
    }
    
    
}
