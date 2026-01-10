import wechat/object.{type JsObject}

import app/pages/common

fn init() -> JsObject {
  object.literal([
    #("theme", "light"),
    #("mode", ""),
  ])
}

fn show_top_tips() -> Nil {
  Nil
}

fn radio_change() -> Nil {
  Nil
}

fn checkbox_change() -> Nil {
  Nil
}

fn bind_date_change() -> Nil {
  Nil
}

fn bind_time_change() -> Nil {
  Nil
}

fn bind_country_code_change() -> Nil {
  Nil
}

fn bind_country_change() -> Nil {
  Nil
}

fn bind_account_change() -> Nil {
  Nil
}

fn bind_agree_change() -> Nil {
  Nil
}

pub fn page() -> JsObject {
  object.literal([
    #("onShow", common.on_show),
    #("showTopTips", show_top_tips),
    #("radioChange", radio_change),
    #("checkboxChange", checkbox_change),
    #("bindDateChange", bind_date_change),
    #("bindTimeChange", bind_time_change),
    #("bindCountryCodeChange", bind_country_code_change),
    #("bindCountryChange", bind_country_change),
    #("bindAccountChange", bind_account_change),
    #("bindAgreeChange", bind_agree_change),
  ])
  |> object.set("data", init())
}
