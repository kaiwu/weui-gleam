import wechat/base
import wechat/object.{type JsObject}
import wechat/util

import app/pages/common

fn init() -> JsObject {
  object.literal([#("theme", "light"), #("mode", "")])
}

fn open_msg_success() -> Nil {
  {
    let url = "../msg_success/msg_success"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

fn open_msg_warn() -> Nil {
  {
    let url = "../msg_warn/msg_warn"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

fn open_msg_text() -> Nil {
  {
    let url = "../msg_text/msg_text"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

fn open_msg_text_primary() -> Nil {
  {
    let url = "../msg_text_primary/msg_text_primary"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

fn open_msg_custom_area_preview() -> Nil {
  {
    let url = "../msg_custom_area_preview/msg_custom_area_preview"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

fn open_msg_custom_area_tips() -> Nil {
  {
    let url = "../msg_custom_area_tips/msg_custom_area_tips"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

fn open_msg_custom_area_cell() -> Nil {
  {
    let url = "../msg_custom_area_cell/msg_custom_area_cell"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
    #("openMsgSuccess", open_msg_success),
    #("openMsgWarn", open_msg_warn),
    #("openMsgText", open_msg_text),
    #("openMsgTextPrimary", open_msg_text_primary),
    #("openMsgCustomAreaPreview", open_msg_custom_area_preview),
    #("openMsgCustomAreaTips", open_msg_custom_area_tips),
    #("openMsgCustomAreaCell", open_msg_custom_area_cell),
  ])
  |> object.set("data", init())
}
