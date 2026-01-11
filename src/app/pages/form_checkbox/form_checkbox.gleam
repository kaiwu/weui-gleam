import wechat/object.{type JsObject}

import app/pages/common
import app/pages/input/input

fn init() -> JsObject {
  object.literal([
    #("theme", "light"),
    #("mode", ""),
  ])
  |> object.set("items", input.init_checkbox())
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
  ])
  |> object.set("checkboxChange", input.checkbox_change)
  |> object.set("data", init())
}
