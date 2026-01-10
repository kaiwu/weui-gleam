import gleam/io
import wechat/app_event
import wechat/object.{type JsObject}

import app/pages/common

fn on_launch() -> Nil {
  io.println("App Launch")
  app_event.on_theme_change(common.change_theme)
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
  |> object.set("data", common.GlobalData(debug: False, theme: "light"))
}
