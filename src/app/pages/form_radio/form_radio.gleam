import wechat/object.{type JsObject}

import app/pages/common

fn init() -> JsObject {
  object.literal([
    #("theme", "light"),
    #("mode", ""),
  ])
  |> object.set("items", "")
}

fn radio_change(e: JsObject) -> Nil {
  echo e
  Nil
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
  ])
  |> object.set("radioChange", radio_change)
  |> object.set("data", init())
}
