import wechat/object.{type JsObject}

import app/pages/common

fn init() -> JsObject {
  object.literal([
    #("theme", "light"),
    #("mode", ""),
  ])
  |> object.set("value", "")
  |> object.set("showClearBtn", False)
  |> object.set("isWaring", False)
  |> object.set("currentValue", "")
  |> object.set("isCurrentWaring", False)
}

fn on_current_input() -> Nil {
  Nil
}

fn on_input(e: JsObject) -> Nil {
  echo e
  Nil
}

fn on_clear() -> Nil {
  Nil
}

fn on_confirm() -> Nil {
  Nil
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
  ])
  |> object.set("onCurrentInput", on_current_input)
  |> object.set("onInput", on_input)
  |> object.set("onClear", on_clear)
  |> object.set("onConfirm", on_confirm)
  |> object.set("data", init())
}
