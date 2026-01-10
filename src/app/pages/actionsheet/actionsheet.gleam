import wechat/object.{type JsObject}

import app/pages/common

fn init() -> JsObject {
  object.literal([
    #("theme", "light"),
    #("mode", ""),
  ])
}

fn close() -> Nil {
  Nil
}

fn open_ios() -> Nil {
  Nil
}

fn open_android() -> Nil {
  Nil
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
    #("close", close),
    #("openIOS", open_ios),
    #("openAndroid", open_android),
  ])
  |> object.set("data", init())
}
