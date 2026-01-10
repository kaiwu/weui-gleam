import wechat/object.{type JsObject}
import wechat/page
import wechat/util

import app/pages/common

fn init() -> JsObject {
  object.literal([
    #("theme", "light"),
    #("mode", ""),
  ])
  |> object.set("topTips", False)
  |> object.set("hide", False)
}

fn close() -> Nil {
  {
    let cp = page.current_page()
    let d = object.literal([#("hide", True)])
    Ok(page.set_data(cp, d, fn() { Nil }))
  }
  |> util.drain
}

fn open() -> Nil {
  {
    let cp = page.current_page()
    let d = object.literal([#("topTips", True)])
    Ok(page.set_data(cp, d, fn() { Nil }))
  }
  |> util.drain
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
    #("close", close),
    #("open", open),
  ])
  |> object.set("data", init())
}
