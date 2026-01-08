import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/io
import gleam/result

import wechat/app
import wechat/app_event
import wechat/object.{type JsObject}
import wechat/page

pub type GlobalData {
  GlobalData(debug: Bool, theme: String)
}

@external(javascript, "../app_ffi.mjs", "generic_decoder")
fn globaldata_from_dynamic(d: Dynamic) -> Result(GlobalData, GlobalData)

fn change_theme(theme: JsObject) -> Nil {
  let _ = {
    use t <- result.try(object.field(theme, "theme", decode.string))
    io.println("change theme to: " <> t)

    use g <- result.try(object.field(
      app.get_app(),
      "data",
      decode.new_primitive_decoder("GlobalData", globaldata_from_dynamic),
    ))
    let r = case g.theme {
      t0 if t0 != t -> app.get_app() |> object.mutate("data.theme", t)
      _ -> object.new()
    }
    Ok(r)
  }
  Nil
}

fn set_theme(p: String) -> Nil {
  let _ = {
    let cp = page.current_page()
    use theme <- result.try(object.path_field(
      app.get_app(),
      "data.theme",
      decode.string,
    ))
    let t = object.literal([#("theme", theme)])
    Ok(page.set_data(cp, t, fn() { io.println(p <> " set theme") }))
  }
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
  |> object.set("data", GlobalData(debug: False, theme: "light"))
}
