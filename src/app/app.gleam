import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/io
import gleam/result

import wechat/app
import wechat/app_event
import wechat/object.{type JsObject}
import wechat/page

pub type GlobalData {
  GlobalData(debug: Bool, theme: JsObject)
}

@external(javascript, "../app_ffi.mjs", "generic_decoder")
fn globaldata_from_dynamic(d: Dynamic) -> Result(GlobalData, GlobalData)

fn change_theme(theme: JsObject) -> Nil {
  let d0 =
    app.get_app()
    |> object.field(
      "data",
      decode.new_primitive_decoder("GlobalData", globaldata_from_dynamic),
    )
    |> result.unwrap(GlobalData(False, theme))
  let _ = app.get_app() |> object.mutate("data", GlobalData(..d0, theme: theme))
  Nil
}

fn set_theme(p: String) -> Nil {
  let cp = page.current_page()
  let theme =
    app.get_app()
    |> object.paths("data.theme")
    |> result.unwrap(object.literal([#("theme", "light")]))
  let _ = page.set_data(cp, theme, fn() { io.println(p <> " set theme") })
  Nil
}

fn on_launch() -> Nil {
  io.println("App Launch")
  app_event.on_theme_change(change_theme)
}

fn on_show() -> Nil {
  io.println("App Show")
}

fn on_hide() -> Nil {
  io.println("App Hide")
}

pub fn app() -> JsObject {
  object.literal([
    #("onLaunch", on_launch),
    #("onShow", on_show),
    #("onHide", on_hide),
  ])
  |> object.set("set_theme", set_theme)
  |> object.set("change_theme", change_theme)
  |> object.set(
    "data",
    GlobalData(debug: False, theme: object.literal([#("theme", "light")])),
  )
}
