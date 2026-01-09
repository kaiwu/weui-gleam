import gleam/list
import gleam/result
import wechat/app as weapp
import wechat/component.{run_component}
import wechat/object.{type JsObject}
import wechat/page.{run_page}

import app/app

import app/pages/button/button
import app/pages/button_bottom_fixed/button_bottom_fixed
import app/pages/button_default/button_default
import app/pages/index/index

pub type Constructor =
  fn() -> JsObject

pub fn app() -> Result(Nil, Nil) {
  app.app() |> weapp.run_app |> Ok
}

pub fn pages() -> List(#(String, Constructor)) {
  [
    #("index", index.page),
    #("button", button.page),
    #("button_default", button_default.page),
    #("button_bottom_fixed", button_bottom_fixed.page),
  ]
}

pub fn components() -> List(#(String, Constructor)) {
  []
}

pub fn page(ps: List(#(String, Constructor)), p: String) -> Result(Nil, Nil) {
  ps
  |> list.find(fn(px) { px.0 == p })
  |> result.try(fn(px) { px.1() |> run_page |> Ok })
}

pub fn component(
  ps: List(#(String, Constructor)),
  p: String,
) -> Result(Nil, Nil) {
  ps
  |> list.find(fn(px) { px.0 == p })
  |> result.try(fn(px) { px.1() |> run_component |> Ok })
}
