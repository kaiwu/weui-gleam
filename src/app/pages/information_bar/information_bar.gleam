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

fn open() -> Nil {
  Nil
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
    #("close", close),
    #("open", open),
  ])
  |> object.set("data", init())
}
