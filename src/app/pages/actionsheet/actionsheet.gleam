import wechat/object.{type JsObject}
import wechat/page
import wechat/util

import app/pages/common

fn init() -> JsObject {
  object.literal([
    #("theme", "light"),
    #("mode", ""),
  ])
  |> object.set("showIOSDialog", False)
  |> object.set("showAndroidDialog", False)
}

fn close() -> Nil {
  {
    let cp = page.current_page()
    let d =
      object.literal([#("showIOSDialog", False), #("showAndroidDialog", False)])
    Ok(page.set_data(cp, d, fn() { Nil }))
  }
  |> util.drain
}

fn open_ios() -> Nil {
  {
    let cp = page.current_page()
    let d = object.literal([#("showIOSDialog", True)])
    Ok(page.set_data(cp, d, fn() { Nil }))
  }
  |> util.drain
}

fn open_android() -> Nil {
  {
    let cp = page.current_page()
    let d = object.literal([#("showAndroidDialog", True)])
    Ok(page.set_data(cp, d, fn() { Nil }))
  }
  |> util.drain
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
    #("close", close),
    #("openIOS", open_ios),
    #("openAndroid", open_android),
  ])
  |> object.set("data", init())
}
