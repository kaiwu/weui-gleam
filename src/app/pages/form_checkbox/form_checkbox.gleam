import wechat/object.{type JsObject}

import app/pages/common

fn init() -> JsObject {
  object.literal([
    #("theme", "light"),
    #("mode", ""),
  ])
  |> object.set("items", "")
}

fn checkbox_change(e: JsObject) -> Nil {
  echo e
  Nil
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
  ])
  |> object.set("checkboxChange", checkbox_change)
  |> object.set("data", init())
}
