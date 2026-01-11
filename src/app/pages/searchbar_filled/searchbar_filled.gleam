import wechat/object.{type JsObject}

import app/pages/common

fn init() -> JsObject {
  object.literal([
    #("theme", "light"),
    #("mode", ""),
  ])
  |> object.set("inputShowed", False)
  |> object.set("inputVal", "")
  |> object.set("isFocus", False)
}

fn show_input() -> Nil {
  Nil
}

fn blur_input() -> Nil {
  Nil
}

fn hide_input() -> Nil {
  Nil
}

fn clear_input() -> Nil {
  Nil
}

fn input_typing(e: JsObject) -> Nil {
  echo e
  Nil
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
  ])
  |> object.set("showInput", show_input)
  |> object.set("blurInput", blur_input)
  |> object.set("hideInput", hide_input)
  |> object.set("clearInput", clear_input)
  |> object.set("inputTyping", input_typing)
  |> object.set("data", init())
}
