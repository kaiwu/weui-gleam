import gleam/dynamic/decode
import gleam/javascript/promise
import gleam/result

import wechat/app
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
  |> object.set("radioItems", "")
  |> object.set("checkboxItems", "")
  |> object.set("countryCodes", "")
  |> object.set("countryCodeIndex", 0)
  |> object.set("countries", "")
  |> object.set("countryIndex", 0)
  |> object.set("accounts", "")
  |> object.set("accountIndex", 0)
  |> object.set("isAgree", False)
}

fn timeout_top_tips_work() -> Nil {
  {
    let cp = page.current_page()
    let t = object.literal([#("showTopTips", False)])
    Ok(page.set_data(cp, t, fn() { Nil }))
  }
  |> util.drain
}

fn show_top_tips() -> Nil {
  {
    let cp = page.current_page()
    let t = object.literal([#("showTopTips", True)])
    use _ <- promise.await(page.set_data(cp, t, fn() { Nil }))
    promise.resolve(
      app.set_timeout(3000, object.new(), fn(_) { timeout_top_tips_work() }),
    )
  }
  |> util.drain
}

fn radio_change(e: JsObject) -> Nil {
  echo e
  Nil
}

fn checkbox_change(e: JsObject) -> Nil {
  echo e
  Nil
}

fn bind_date_change(e: JsObject) -> Nil {
  echo e
  Nil
}

fn bind_time_change(e: JsObject) -> Nil {
  echo e
  Nil
}

fn bind_country_code_change(e: JsObject) -> Nil {
  echo object.field(e, "detail.value", decode.int)
    |> result.try(fn(a) {
      let d = object.literal([]) |> object.set("countryCodeIndex", a)
      let cp = page.current_page()
      Ok(page.set_data(cp, d, fn() { Nil }))
    })
    |> util.drain
}

fn bind_country_change(e: JsObject) -> Nil {
  echo object.field(e, "detail.value", decode.int)
    |> result.try(fn(a) {
      let d = object.literal([]) |> object.set("countryIndex", a)
      let cp = page.current_page()
      Ok(page.set_data(cp, d, fn() { Nil }))
    })
    |> util.drain
}

fn bind_account_change(e: JsObject) -> Nil {
  echo object.field(e, "detail.value", decode.int)
    |> result.try(fn(a) {
      let d = object.literal([]) |> object.set("accountIndex", a)
      let cp = page.current_page()
      Ok(page.set_data(cp, d, fn() { Nil }))
    })
    |> util.drain
}

fn bind_agree_change(e: JsObject) -> Nil {
  echo e
  Nil
}

pub fn page() -> JsObject {
  object.literal([
    #("bindPickerChange", bind_date_change),
    #("bindTimeChange", bind_time_change),
  ])
  |> object.set("onShow", common.on_show)
  |> object.set("showTopTips", show_top_tips)
  |> object.set("radioChange", radio_change)
  |> object.set("checkboxChange", checkbox_change)
  |> object.set("bindDateChange", bind_date_change)
  |> object.set("bindCountryCodeChange", bind_country_code_change)
  |> object.set("bindCountryChange", bind_country_change)
  |> object.set("bindAccountChange", bind_account_change)
  |> object.set("bindAgreeChange", bind_agree_change)
  |> object.set("data", init())
}
