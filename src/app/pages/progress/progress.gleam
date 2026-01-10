import gleam/dynamic/decode
import gleam/result

import wechat/app
import wechat/object.{type JsObject}
import wechat/page
import wechat/util

import app/pages/common

fn init() -> JsObject {
  object.literal([
    #("theme", "light"),
    #("mode", ""),
  ])
  |> object.set("progress", 0)
  |> object.set("disabled", False)
}

fn upload_next(progress: Int) -> Nil {
  let cp = page.current_page()
  case progress {
    p if p >= 100 -> {
      let d0 =
        object.new()
        |> object.set("disabled", False)
        |> object.set("progress", 0)
      let _ = page.set_data(cp, d0, fn() { Nil })
      Nil
    }
    other -> {
      let empty = object.new()
      let d0 = object.literal([#("progress", other)])
      let _ = page.set_data(cp, d0, fn() { Nil })
      let _ = app.set_timeout(20, empty, fn(_o) { upload_next(other + 1) })
      Nil
    }
  }
}

fn upload() -> Nil {
  {
    use data <- result.try(page.get_data(0))
    use disabled <- result.try(object.field(data, "disabled", decode.bool))
    use progress <- result.try(object.field(data, "progress", decode.int))
    case disabled {
      True -> Ok(Nil)
      False -> {
        let cp = page.current_page()
        let d0 =
          object.new()
          |> object.set("disabled", True)
          |> object.set("progress", 0)
        let _ = page.set_data(cp, d0, fn() { Nil })
        Ok(upload_next(progress))
      }
    }
  }
  |> util.drain
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
    #("upload", upload),
  ])
  |> object.set("data", init())
}
