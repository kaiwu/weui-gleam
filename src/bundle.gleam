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
import app/pages/dialog/dialog
import app/pages/flex/flex
import app/pages/footer/footer
import app/pages/form/form
import app/pages/form_access/form_access
import app/pages/form_bottom_fixed/form_bottom_fixed
import app/pages/form_checkbox/form_checkbox
import app/pages/form_input_status/form_input_status
import app/pages/form_page/form_page
import app/pages/form_radio/form_radio
import app/pages/form_select/form_select
import app/pages/form_switch/form_switch
import app/pages/form_textarea/form_textarea
import app/pages/form_vcode/form_vcode
import app/pages/form_vertical/form_vertical
import app/pages/gallery/gallery
import app/pages/grid/grid
import app/pages/half_screen_dialog/half_screen_dialog
import app/pages/icons/icons
import app/pages/index/index
import app/pages/information_bar/information_bar
import app/pages/input/input
import app/pages/list/list as pagelist
import app/pages/loading/loading
import app/pages/loadmore/loadmore
import app/pages/msg/msg
import app/pages/msg_custom_area_cell/msg_custom_area_cell
import app/pages/msg_custom_area_preview/msg_custom_area_preview
import app/pages/msg_custom_area_tips/msg_custom_area_tips
import app/pages/msg_success/msg_success
import app/pages/msg_text/msg_text
import app/pages/msg_text_primary/msg_text_primary
import app/pages/msg_warn/msg_warn
import app/pages/navbar/navbar
import app/pages/navigation_bar/navigation_bar
import app/pages/panel/panel
import app/pages/picker/picker
import app/pages/preview/preview
import app/pages/progress/progress
import app/pages/searchbar/searchbar
import app/pages/searchbar_filled/searchbar_filled
import app/pages/searchbar_grey/searchbar_grey
import app/pages/searchbar_homepage/searchbar_homepage
import app/pages/searchbar_outlined/searchbar_outlined
import app/pages/slider/slider
import app/pages/slideview/slideview
import app/pages/steps/steps
import app/pages/steps_horizonal/steps_horizonal
import app/pages/steps_vertical/steps_vertical
import app/pages/tabbar/tabbar
import app/pages/toast/toast
import app/pages/top_tips/top_tips
import app/pages/uploader/uploader

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
    #("dialog", dialog.page),
    #("flex", flex.page),
    #("footer", footer.page),
    #("form", form.page),
    #("form_access", form_access.page),
    #("form_bottom_fixed", form_bottom_fixed.page),
    #("form_checkbox", form_checkbox.page),
    #("form_input_status", form_input_status.page),
    #("form_page", form_page.page),
    #("form_radio", form_radio.page),
    #("form_select", form_select.page),
    #("form_switch", form_switch.page),
    #("form_textarea", form_textarea.page),
    #("form_vcode", form_vcode.page),
    #("form_vertical", form_vertical.page),
    #("gallery", gallery.page),
    #("grid", grid.page),
    #("half_screen_dialog", half_screen_dialog.page),
    #("icons", icons.page),
    #("information_bar", information_bar.page),
    #("input", input.page),
    #("list", pagelist.page),
    #("loading", loading.page),
    #("loadmore", loadmore.page),
    #("msg", msg.page),
    #("msg_custom_area_cell", msg_custom_area_cell.page),
    #("msg_custom_area_preview", msg_custom_area_preview.page),
    #("msg_custom_area_tips", msg_custom_area_tips.page),
    #("msg_success", msg_success.page),
    #("msg_text", msg_text.page),
    #("msg_text_primary", msg_text_primary.page),
    #("msg_warn", msg_warn.page),
    #("navbar", navbar.page),
    #("navigation_bar", navigation_bar.page),
    #("panel", panel.page),
    #("picker", picker.page),
    #("preview", preview.page),
    #("progress", progress.page),
    #("searchbar", searchbar.page),
    #("searchbar_filled", searchbar_filled.page),
    #("searchbar_grey", searchbar_grey.page),
    #("searchbar_homepage", searchbar_homepage.page),
    #("searchbar_outlined", searchbar_outlined.page),
    #("slider", slider.page),
    #("slideview", slideview.page),
    #("steps", steps.page),
    #("steps_horizonal", steps_horizonal.page),
    #("steps_vertical", steps_vertical.page),
    #("tabbar", tabbar.page),
    #("toast", toast.page),
    #("top_tips", top_tips.page),
    #("uploader", uploader.page),
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
