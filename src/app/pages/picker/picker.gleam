import wechat/object.{type JsObject}

import app/pages/common

fn init() -> JsObject {
  object.literal([
    #("theme", "light"),
    #("mode", ""),
  ])
}

fn bind_picker_change() -> Nil {
  Nil
}

fn bind_date_change() -> Nil {
  Nil
}

fn bind_time_change() -> Nil {
  Nil
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
    #("bindPickerChange", bind_picker_change),
    #("bindDateChange", bind_date_change),
    #("bindTimeChange", bind_time_change),
  ])
  |> object.set("data", init())
}
