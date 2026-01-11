import gleam/dynamic/decode
import gleam/result

import wechat/object.{type JsObject}
import wechat/page
import wechat/util

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
  {
    let cp = page.current_page()
    let d = object.literal([#("inputShowed", True)])
    Ok(page.set_data(cp, d, fn() { Nil }))
  }
  |> util.drain
}

fn blur_input() -> Nil {
  {
    let cp = page.current_page()
    let d = object.literal([#("isFocus", False)])
    Ok(page.set_data(cp, d, fn() { Nil }))
  }
  |> util.drain
}

fn hide_input() -> Nil {
  {
    let cp = page.current_page()
    let d =
      object.new()
      |> object.set("inputVal", "")
      |> object.set("inputShowed", False)
    Ok(page.set_data(cp, d, fn() { Nil }))
  }
  |> util.drain
}

fn clear_input() -> Nil {
  {
    let cp = page.current_page()
    let d = object.literal([]) |> object.set("inputVal", "")
    Ok(page.set_data(cp, d, fn() { Nil }))
  }
  |> util.drain
}

fn input_typing(e: JsObject) -> Nil {
  {
    let cp = page.current_page()
    use value <- result.try(object.path_field(e, "detail.value", decode.string))
    let d =
      object.new()
      |> object.set("inputVal", value)
      |> object.set("isFocus", True)
    Ok(page.set_data(cp, d, fn() { Nil }))
  }
  |> util.drain
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
