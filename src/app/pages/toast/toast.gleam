import gleam/javascript/promise

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
}

fn open_toast() -> Nil {
  {
    let cp = page.current_page()
    let t0 = object.literal([#("toast", True)])
    let t1 = object.literal([#("hideToast", True)])
    let t2 = object.literal([#("toast", False), #("hideToast", False)])
    let empty = object.new()
    use _ <- promise.await(page.set_data(cp, t0, fn() { Nil }))
    {
      use _ <- app.set_timeout(300, empty)
      todo
    }
    |> promise.resolve()
  }
  |> util.drain
}

fn open_warn_toast() -> Nil {
  Nil
}

fn open_text_more_toast() -> Nil {
  Nil
}

fn open_text_toast() -> Nil {
  Nil
}

fn open_loading() -> Nil {
  Nil
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
    #("openToast", open_toast),
    #("openWarnToast", open_warn_toast),
    #("openTextMoreToast", open_text_more_toast),
    #("openTextToast", open_text_toast),
    #("openLoading", open_loading),
  ])
  |> object.set("data", init())
}
