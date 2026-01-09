import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/result

import wechat/app
import wechat/base
import wechat/object.{type JsObject, type WechatCallback}
import wechat/util

@external(javascript, "../../../app_ffi.mjs", "generic_decoder")
fn set_theme(d: Dynamic) -> Result(WechatCallback, WechatCallback)

fn init() -> JsObject {
  object.literal([
    #("theme", "light"),
    #("mode", ""),
  ])
}

fn on_show() -> Nil {
  {
    let app = app.get_app()
    let decoder = decode.new_primitive_decoder("set_theme", set_theme)
    use set_theme <- result.try(object.field(app, "set_theme", decoder))
    Ok(set_theme())
  }
  |> util.drain
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
    #("onShow", on_show),
    #("openDefault", open_default),
    #("openBottomfixed", open_bottom_fixed),
  ])
  |> object.set("data", init())
}
