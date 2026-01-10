import wechat/base
import wechat/object.{type JsObject}
import wechat/util

import app/pages/common

fn init() -> JsObject {
  object.literal([
    #("theme", "light"),
    #("mode", ""),
  ])
}

fn open_default() -> Nil {
  {
    let url = "../button_default/button_default"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

fn open_bottom_fixed() -> Nil {
  {
    let url = "../button_bottom_fixed/button_bottom_fixed"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
    #("openDefault", open_default),
    #("openBottomfixed", open_bottom_fixed),
  ])
  |> object.set("data", init())
}
