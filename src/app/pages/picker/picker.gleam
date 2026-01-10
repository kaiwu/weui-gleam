import gleam/dynamic/decode
import gleam/javascript/array
import gleam/result
import wechat/object.{type JsObject}
import wechat/page
import wechat/util

import app/pages/common

fn init() -> JsObject {
  object.literal([
    #("theme", "light"),
    #("mode", ""),
    #("date", "2016-09-01"),
    #("time", "12:01"),
  ])
  |> object.set(
    "array",
    array.from_list([
      "美国",
      "中国",
      "巴西",
      "日本",
    ]),
  )
  |> object.set("index", 0)
}

fn bind_picker_change(e: JsObject) -> Nil {
  echo object.field(e, "detail.value", decode.int)
    |> result.try(fn(a) {
      let index = object.literal([#("index", a)])
      let cp = page.current_page()
      Ok(page.set_data(cp, index, fn() { Nil }))
    })
    |> util.drain
}

fn bind_date_change(e: JsObject) -> Nil {
  {
    let cp = page.current_page()
    use value <- result.try(object.path_field(e, "detail.value", decode.string))
    let d = object.literal([#("date", value)])
    Ok(page.set_data(cp, d, fn() { Nil }))
  }
  |> util.drain
}

fn bind_time_change(e: JsObject) -> Nil {
  {
    let cp = page.current_page()
    use value <- result.try(object.path_field(e, "detail.value", decode.string))
    let d = object.literal([#("time", value)])
    Ok(page.set_data(cp, d, fn() { Nil }))
  }
  |> util.drain
}

pub fn page() -> JsObject {
  object.literal([
    #("bindPickerChange", bind_picker_change),
    #("bindDateChange", bind_date_change),
    #("bindTimeChange", bind_time_change),
  ])
  |> object.set("data", init())
  |> object.set("onShow", common.on_show)
}
