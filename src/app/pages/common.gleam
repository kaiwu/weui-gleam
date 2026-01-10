import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/result

import wechat/app
import wechat/object.{type JsObject, type WechatCallback}
import wechat/util

@external(javascript, "../../app_ffi.mjs", "generic_decoder")
fn set_theme(d: Dynamic) -> Result(WechatCallback, WechatCallback)

pub fn on_show() -> Nil {
  {
    let app = app.get_app()
    let decoder = decode.new_primitive_decoder("set_theme", set_theme)
    use set_theme <- result.try(object.field(app, "set_theme", decoder))
    Ok(set_theme())
  }
  |> util.drain
}

pub fn on_load(_query: JsObject) -> Nil {
  Nil
}
