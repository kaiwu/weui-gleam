import gleam/io
import gleam/result

import app/pages/index/index
import wechat/app
import wechat/app_event
import wechat/object.{type JsObject}

fn change_theme(o: JsObject) -> Nil {
  let _ =
    app.get_app()
    |> object.mutate(
      "data.theme",
      object.get(o, "theme")
        |> result.try(object.string)
        |> result.unwrap("light"),
    )
  let _ =
    app.get_app()
    |> object.paths("data.themeListeners")
  Nil
}

fn on_launch(_o: JsObject) -> Nil {
  io.println("App Launch")
  app_event.on_theme_change(change_theme)
}

fn on_show(_o: JsObject) -> Nil {
  Nil
}

pub fn app() -> JsObject {
  object.literal([#("onLaunch", on_launch), #("onShow", on_show)])
  |> object.set(
    "data",
    object.new()
      |> object.set("themeListeners", [index.on_theme_change])
      |> object.set("theme", "light"),
  )
}
