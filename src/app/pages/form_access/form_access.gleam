import wechat/object.{type JsObject}

import app/pages/common

fn init() -> JsObject {
  object.literal([
    #("theme", "light"),
    #("mode", ""),
  ])
  |> object.set("vcodeValue", False)
  |> object.set("msg", False)
  |> object.set("checkValue", 1)
  |> object.set("check", False)
}

fn bind_vcode_input(e: JsObject) -> Nil {
  echo e
  Nil
}

fn check_status() -> Nil {
  echo "check_status called"
  Nil
}

fn checkbox_change(e: JsObject) -> Nil {
  echo e
  Nil
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
  ])
  |> object.set("bindVcodeInput", bind_vcode_input)
  |> object.set("checkStatus", check_status)
  |> object.set("checkboxChange", checkbox_change)
  |> object.set("data", init())
}
