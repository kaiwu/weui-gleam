import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/io
import gleam/list
import gleam/result

import app/pages/index/index
import wechat/app
import wechat/app_event
import wechat/object.{type JsObject}

pub type Listener =
  fn(String) -> Nil

pub type GlobalData {
  GlobalData(listeners: List(Listener), theme: String)
}

@external(javascript, "../app_ffi.mjs", "globaldata_from_dynamic")
fn globaldata_from_dynamic(d: Dynamic) -> Result(GlobalData, GlobalData)

fn change_theme(o: JsObject) -> Nil {
  let theme: String =
    object.get(o, "theme")
    |> result.try(object.string)
    |> result.unwrap("light")
  let d0 =
    app.get_app()
    |> object.field(
      "data",
      decode.new_primitive_decoder("GlobalData", globaldata_from_dynamic),
    )
    |> result.unwrap(GlobalData([], "light"))
  let d1 = GlobalData(..d0, theme: theme)

  list.each(d0.listeners, fn(f) { f(theme) })
  app.get_app() |> object.mutate("data", d1)
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
  |> object.set(
    "data",
    GlobalData(listeners: [index.on_theme_change], theme: "light"),
  )
}
