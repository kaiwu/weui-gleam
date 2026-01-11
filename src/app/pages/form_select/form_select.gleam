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
  |> object.set("array1", "")
  |> object.set("array2", "")
  |> object.set("array3", "")
  |> object.set("value1", 0)
  |> object.set("value2", 0)
  |> object.set("value3", 0)
}

fn bind_picker_1_change(e: JsObject) -> Nil {
  {
    let cp = page.current_page()
    use value <- result.try(object.path_field(e, "detail.value", decode.int))
    let d = object.literal([]) |> object.set("value1", value)
    Ok(page.set_data(cp, d, fn() { Nil }))
  }
  |> util.drain
}

fn bind_picker_2_change(e: JsObject) -> Nil {
  {
    let cp = page.current_page()
    use value <- result.try(object.path_field(e, "detail.value", decode.int))
    let d = object.literal([]) |> object.set("value2", value)
    Ok(page.set_data(cp, d, fn() { Nil }))
  }
  |> util.drain
}

fn bind_picker_3_change(e: JsObject) -> Nil {
  {
    let cp = page.current_page()
    use value <- result.try(object.path_field(e, "detail.value", decode.int))
    let d = object.literal([]) |> object.set("value3", value)
    Ok(page.set_data(cp, d, fn() { Nil }))
  }
  |> util.drain
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
  ])
  |> object.set("bindPicker1Change", bind_picker_1_change)
  |> object.set("bindPicker2Change", bind_picker_2_change)
  |> object.set("bindPicker3Change", bind_picker_3_change)
  |> object.set("data", init())
}
