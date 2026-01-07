import gleam/list
import gleam/result
import wechat/app as weapp
import wechat/component.{run_component}
import wechat/object.{type JsObject}
import wechat/page.{run_page}

import app/app

import app/components/cell/cell
import app/components/cells/cells
import app/components/navigation_bar/navigation_bar
import app/pages/index/index

pub type Constructor =
  fn() -> JsObject

pub fn app() -> Result(Nil, Nil) {
  app.app() |> weapp.run_app |> Ok
}

pub fn pages() -> List(#(String, Constructor)) {
  [#("index", index.page)]
}

pub fn components() -> List(#(String, Constructor)) {
  [
    #("cell", cell.component),
    #("cells", cells.component),
    #("navigation_bar", navigation_bar.component),
  ]
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
