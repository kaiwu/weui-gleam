import wechat/object.{type JsObject}

import app/pages/common

fn init() -> JsObject {
  object.literal([
    #("theme", "light"),
    #("mode", ""),
  ])
}

fn open_toast() -> Nil {
  Nil
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
