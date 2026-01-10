import wechat/base
import wechat/object.{type JsObject}
import wechat/util

import app/pages/common

fn init() -> JsObject {
  object.literal([#("theme", "light"), #("mode", "")])
}

fn open_searchbar_filled() -> Nil {
  {
    let url = "../searchbar_filled/searchbar_filled"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

fn open_searchbar_grey() -> Nil {
  {
    let url = "../searchbar_grey/searchbar_grey"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

fn open_searchbar_outlined() -> Nil {
  {
    let url = "../searchbar_outlined/searchbar_outlined"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

fn open_searchbar_homepage() -> Nil {
  {
    let url = "../searchbar_homepage/searchbar_homepage"
    base.navigate_to(url, fn() { Nil })
  }
  |> util.drain
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
    #("openSearchbarFilled", open_searchbar_filled),
    #("openSearchbarGrey", open_searchbar_grey),
    #("openSearchbarOutlined", open_searchbar_outlined),
    #("openSearchbarHomepage", open_searchbar_homepage),
  ])
  |> object.set("data", init())
}
