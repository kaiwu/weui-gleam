import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/javascript/array.{type Array}
import gleam/javascript/promise
import gleam/list
import gleam/result

import wechat/app
import wechat/object.{type JsObject}
import wechat/page
import wechat/util

import app/pages/common

pub type Item {
  Item(name: String, value: String, checked: Bool)
}

@external(javascript, "../../../app_ffi.mjs", "generic_decoder")
fn item_from_dynamic(d: Dynamic) -> Result(Item, Item)

pub fn init_radio() -> Array(Item) {
  array.from_list([
    Item("cell standard", "0", False),
    Item("cell alternative", "1", True),
  ])
}

pub fn init_checkbox() -> Array(Item) {
  array.from_list([
    Item("standard is dealt for u.", "0", True),
    Item("standard is delicient for u.", "1", False),
  ])
}

pub fn init() -> JsObject {
  object.literal([
    #("theme", "light"),
    #("mode", ""),
    #("date", "2016-09-01"),
    #("time", "12:01"),
  ])
  |> object.set("radioItems", init_radio())
  |> object.set("checkboxItems", init_checkbox())
  |> object.set(
    "countryCodes",
    array.from_list([
      "+86",
      "+80",
      "+84",
      "+87",
    ]),
  )
  |> object.set("countryCodeIndex", 0)
  |> object.set(
    "countries",
    array.from_list([
      "中国",
      "美国",
      "英国",
    ]),
  )
  |> object.set("countryIndex", 0)
  |> object.set(
    "accounts",
    array.from_list([
      "微信号",
      "QQ",
      "Email",
    ]),
  )
  |> object.set("accountIndex", 0)
  |> object.set("isAgree", False)
}

fn timeout_top_tips_work(t: JsObject) -> Nil {
  {
    let cp = page.current_page()
    Ok(page.set_data(cp, t, fn() { Nil }))
  }
  |> util.drain
}

fn show_top_tips() -> Nil {
  {
    let cp = page.current_page()
    let t0 = object.literal([#("showTopTips", True)])
    let t1 = object.literal([#("showTopTips", False)])
    use _ <- promise.await(page.set_data(cp, t0, fn() { Nil }))
    promise.resolve(app.set_timeout(3000, t1, timeout_top_tips_work))
  }
  |> util.drain
}

pub fn radio_change(e: JsObject) -> Nil {
  {
    use v <- result.try(object.path_field(e, "detail.value", decode.string))
    use d <- result.try(page.get_data(0))
    let decoder = decode.new_primitive_decoder("item", item_from_dynamic)
    use items <- result.try(object.field(d, "items", decode.list(decoder)))
    let ls =
      list.fold(items, [], fn(ls, i) {
        list.append(ls, [Item(..i, checked: i.value == v)])
      })
    let cp = page.current_page()
    let rs = object.literal([#("items", array.from_list(ls))])
    Ok(page.set_data(cp, rs, fn() { Nil }))
  }
  |> util.drain
}

pub fn checkbox_change(e: JsObject) -> Nil {
  {
    use vs <- result.try(object.path_field(
      e,
      "detail.value",
      decode.list(decode.string),
    ))
    use d <- result.try(page.get_data(0))
    let decoder = decode.new_primitive_decoder("item", item_from_dynamic)
    use items <- result.try(object.field(d, "items", decode.list(decoder)))
    let ls =
      list.fold(items, [], fn(ls, i) {
        list.append(ls, [Item(..i, checked: list.contains(vs, i.value))])
      })
    let cp = page.current_page()
    let rs = object.literal([#("items", array.from_list(ls))])
    Ok(page.set_data(cp, rs, fn() { Nil }))
  }
  |> util.drain
}

fn bind_country_code_change(e: JsObject) -> Nil {
  echo object.field(e, "detail.value", decode.int)
    |> result.try(fn(a) {
      let d = object.literal([#("countryCodeIndex", a)])
      let cp = page.current_page()
      Ok(page.set_data(cp, d, fn() { Nil }))
    })
    |> util.drain
}

fn bind_country_change(e: JsObject) -> Nil {
  echo object.field(e, "detail.value", decode.int)
    |> result.try(fn(a) {
      let d = object.literal([#("countryIndex", a)])
      let cp = page.current_page()
      Ok(page.set_data(cp, d, fn() { Nil }))
    })
    |> util.drain
}

fn bind_account_change(e: JsObject) -> Nil {
  echo object.field(e, "detail.value", decode.int)
    |> result.try(fn(a) {
      let d = object.literal([#("accountIndex", a)])
      let cp = page.current_page()
      Ok(page.set_data(cp, d, fn() { Nil }))
    })
    |> util.drain
}

pub fn page() -> JsObject {
  object.new()
  |> object.set("onShow", common.on_show)
  |> object.set("showTopTips", show_top_tips)
  |> object.set("radioChange", radio_change)
  |> object.set("checkboxChange", checkbox_change)
  |> object.set("bindCountryCodeChange", bind_country_code_change)
  |> object.set("bindCountryChange", bind_country_change)
  |> object.set("bindAccountChange", bind_account_change)
  |> object.set("data", init())
}
