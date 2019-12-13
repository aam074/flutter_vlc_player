// LARSON CARTER

var _videoView: UIView?
weak var _messenger: (NSObjectProtocol & FlutterBinaryMessenger)?

class FLTPlayerView {
    class func initWith(_ view: UIView?) -> Self {
        if _videoView == nil {
            _videoView = view
        }
        return super.init()
    }

    func view() -> UIView {
        return _videoView!
    }
}

weak var _registrar: (NSObjectProtocol & FlutterPluginRegistrar)?
var _view: UIView?

class FLTPlayerViewFactory {
    class func initWithRegistrar(_ registrar: (NSObjectProtocol & FlutterPluginRegistrar)?, _ view: UIView?) -> Self {
        _registrar = registrar
        _view = view
        return super.init()
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments messenger: (NSObjectProtocol & FlutterBinaryMessenger)?) -> (NSObjectProtocol & FlutterPlatformView) {
        let _methodCallName = "\("flutter_video_plugin/getVideoView")_\(String(format: "%lld", viewId))"
        let _channel = FlutterMethodChannel(name: _methodCallName, binaryMessenger: _registrar?.messenger())
        _registrar?.addMethodCallDelegate(FlutterVlcPlayerPlugin(), channel: _channel)
        return FLTPlayerView.initWith(_view)
    }
}

var _player: VLCMediaPlayer?
var _result: FlutterResult?
var _view: UIView?

class FlutterVlcPlayerPlugin {
    class func register(withRegistrar registrar: (NSObjectProtocol & FlutterPluginRegistrar)) {
        let _rect = CGRect(x: 0, y: 0, width: 700, height: 100)
        _view = UIView(frame: _rect)
        _view?.contentMode = .scaleAspectFit
        _view?.backgroundColor = UIColor.white
        _view?.clipsToBounds = true
        _view?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        registrar.register(FLTPlayerViewFactory(registrar: registrar, _view), withId: "flutter_video_plugin/getVideoView")
    }

do {
    //result = result    // Skipping redundant initializing to itself
    let _methodName = call.method
    if (_methodName == "playVideo") {
        let _url = call.arguments["url"] as? String
        player = VLCMediaPlayer()
        let _media = VLCMedia(url: URL(string: _url ?? ""))
        player.media = _media
        player.position = 0.5

        player.drawable = videoView
        player.addObserver(self, forKeyPath: "state", options: .new, context: nil)
        player.play()
    } else if (_methodName == "dispose") {
        player.stop()
    } else if (_methodName == "getSnapshot") {
        let _drawable = player.drawable
        let _size = _drawable?.frame.size

        UIGraphicsBeginImageContextWithOptions(_size ?? CGSize.zero, _: false, _: 0.0)

        let rec = _drawable?.frame
        _drawable?.drawHierarchy(in: rec ?? CGRect.zero, afterScreenUpdates: false)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let _byteArray = ?.base64EncodedString(options: .lineLength64Characters)

        result([
        "snapshot": _byteArray ?? ""
        ])
    }
}

do {

    if player.isPlaying() {
        player.drawable = view
        player.videoAspectRatio = "0.7"
        player.currentVideoTrackIndex = 0
        player.scaleFactor = 0.0
        let _aspectRatioChar = player.videoAspectRatio()
        var _aspectRatio: NSNumber? = nil
        if let _aspectRatioChar = _aspectRatioChar {
            _aspectRatio = "\(_aspectRatioChar)" as? NSNumber
        }

        if let _aspectRatio = _aspectRatio {
            result([
            "aspectRatio": _aspectRatio
            ])
        }
        //        _result(nil);
    }

}

