import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/io
import gleam/result

import wechat/app
import wechat/object.{type JsObject}
import wechat/page
import wechat/util

pub type GlobalData {
  GlobalData(debug: Bool, theme: String)
}

@external(javascript, "../../app_ffi.mjs", "generic_decoder")
fn globaldata_from_dynamic(d: Dynamic) -> Result(GlobalData, GlobalData)

pub fn change_theme(theme: JsObject) -> Nil {
  {
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
  |> util.drain
}

pub fn set_theme() -> Nil {
  {
    let cp = page.current_page()
    use theme <- result.try(object.path_field(
      app.get_app(),
      "data.theme",
      decode.string,
    ))
    let t = object.literal([#("theme", theme)])
    Ok(page.set_data(cp, t, fn() { Nil }))
  }
  |> util.drain
}

pub fn on_show() -> Nil {
  set_theme()
}

pub fn on_load(_query: JsObject) -> Nil {
  Nil
}
