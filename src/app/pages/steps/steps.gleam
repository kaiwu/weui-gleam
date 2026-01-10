import wechat/base
import wechat/object.{type JsObject}
import wechat/util

import app/pages/common

fn init() -> JsObject {
  object.literal([
    #("theme", "light"),
    #("mode", ""),
  ])
}

fn open_steps_vertical() -> Nil {
  {
    let url = "../steps_vertical/steps_vertical"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

fn open_steps_horizonal() -> Nil {
  {
    let url = "../steps_horizonal/steps_horizonal"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
    #("openStepsVertical", open_steps_vertical),
    #("openStepsHorizonal", open_steps_horizonal),
  ])
  |> object.set("data", init())
}
