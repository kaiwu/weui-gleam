import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/io
import gleam/javascript/promise
import gleam/result

import wechat/app
import wechat/object.{type JsObject, type WechatCallback}
import wechat/page
import wechat/util
import wechat/wxml

@external(javascript, "../../../app_ffi.mjs", "generic_decoder")
fn set_theme(d: Dynamic) -> Result(WechatCallback, WechatCallback)

fn init() -> JsObject {
  object.literal([
    #("theme", "light"),
    #("mode", ""),
  ])
  |> object.set("wrap", False)
}

fn bounding(rect: JsObject) -> Nil {
  {
    use height <- result.try(object.field(rect, "height", decode.int))
    echo height
    Ok(case height {
      h if h >= 48 -> {
        let cp = page.current_page()
        let wrap = object.literal([#("wrap", True)])
        page.set_data(cp, wrap, fn() { Nil })
      }
      _ -> promise.resolve(Ok(object.new()))
    })
  }
  |> util.drain
}

fn check_box_change() -> Nil {
  io.println("check box clicked")
}

fn on_show() -> Nil {
  let _ = {
    let app = app.get_app()
    let decoder = decode.new_primitive_decoder("set_theme", set_theme)
    use set_theme <- result.try(object.field(app, "set_theme", decoder))
    Ok(set_theme())
  }
  wxml.create_selector_query()
  |> wxml.selector_query_select("#js_btn")
  |> wxml.nodes_ref_bounding_client_rect(bounding)
  |> wxml.selector_query_exec()
  |> util.drain
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", on_show),
    #("checkboxChange", check_box_change),
  ])
  |> object.set("data", init())
}
