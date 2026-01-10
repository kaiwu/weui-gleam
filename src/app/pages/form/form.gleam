import wechat/base
import wechat/object.{type JsObject}
import wechat/util

import app/pages/common

fn init() -> JsObject {
  object.literal([#("theme", "light"), #("mode", "")])
}

fn open_form_page() -> Nil {
  {
    let url = "../form_page/form_page"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

fn open_form_input_status() -> Nil {
  {
    let url = "../form_input_status/form_input_status"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

fn open_form_vcode() -> Nil {
  {
    let url = "../form_vcode/form_vcode"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

fn open_form_bottom_fixed() -> Nil {
  {
    let url = "../form_bottom_fixed/form_bottom_fixed"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

fn open_form_access() -> Nil {
  {
    let url = "../form_access/form_access"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

fn open_form_checkbox() -> Nil {
  {
    let url = "../form_checkbox/form_checkbox"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

fn open_form_radio() -> Nil {
  {
    let url = "../form_radio/form_radio"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

fn open_form_switch() -> Nil {
  {
    let url = "../form_switch/form_switch"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

fn open_form_select() -> Nil {
  {
    let url = "../form_select/form_select"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

fn open_form_textarea() -> Nil {
  {
    let url = "../form_textarea/form_textarea"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

fn open_form_vertical() -> Nil {
  {
    let url = "../form_vertical/form_vertical"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
    #("openFormPage", open_form_page),
    #("openFormInputStatus", open_form_input_status),
    #("openFormVcode", open_form_vcode),
    #("openFormBottomFixed", open_form_bottom_fixed),
    #("openFormAccess", open_form_access),
    #("openFormCheckbox", open_form_checkbox),
    #("openFormRadio", open_form_radio),
    #("openFormSwitch", open_form_switch),
    #("openFormSelect", open_form_select),
    #("openFormTextarea", open_form_textarea),
    #("openFormVertical", open_form_vertical),
  ])
  |> object.set("data", init())
}
