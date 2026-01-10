import gleam/list
import gleam/result
import wechat/app as weapp
import wechat/component.{run_component}
import wechat/object.{type JsObject}
import wechat/page.{run_page}

import app/app

import app/pages/actionsheet/actionsheet
import app/pages/article/article
import app/pages/badge/badge
import app/pages/button/button
import app/pages/button_bottom_fixed/button_bottom_fixed
import app/pages/button_default/button_default
import app/pages/flex/flex
import app/pages/footer/footer
import app/pages/gallery/gallery
import app/pages/grid/grid
import app/pages/icons/icons
import app/pages/index/index
import app/pages/information_bar/information_bar
import app/pages/input/input
import app/pages/list/list as pagelist
import app/pages/loading/loading
import app/pages/loadmore/loadmore
import app/pages/navigation_bar/navigation_bar
import app/pages/panel/panel
import app/pages/picker/picker
import app/pages/preview/preview
import app/pages/progress/progress
import app/pages/slider/slider
import app/pages/slideview/slideview
import app/pages/steps/steps
import app/pages/steps_horizonal/steps_horizonal
import app/pages/steps_vertical/steps_vertical
import app/pages/toast/toast
import app/pages/top_tips/top_tips

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
    #("actionsheet", actionsheet.page),
    #("article", article.page),
    #("badge", badge.page),
    #("flex", flex.page),
    #("footer", footer.page),
    #("gallery", gallery.page),
    #("grid", grid.page),
    #("icons", icons.page),
    #("information_bar", information_bar.page),
    #("input", input.page),
    #("list", pagelist.page),
    #("loading", loading.page),
    #("loadmore", loadmore.page),
    #("navigation_bar", navigation_bar.page),
    #("panel", panel.page),
    #("picker", picker.page),
    #("preview", preview.page),
    #("progress", progress.page),
    #("slider", slider.page),
    #("slideview", slideview.page),
    #("steps", steps.page),
    #("steps_horizonal", steps_horizonal.page),
    #("steps_vertical", steps_vertical.page),
    #("toast", toast.page),
    #("top_tips", top_tips.page),
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
