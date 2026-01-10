import wechat/object.{type JsObject}

import app/pages/common

fn init() -> JsObject {
  object.literal([
    #("theme", "light"),
    #("mode", ""),
  ])
}

fn upload() -> Nil {
  Nil
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
    #("upload", upload),
  ])
  |> object.set("data", init())
}
