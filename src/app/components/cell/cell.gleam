import gleam/dynamic/decode
import gleam/javascript/promise
import gleam/result

import wechat/base
import wechat/component
import wechat/object.{type JsObject}
import wechat/page
import wechat/util

@external(javascript, "../../../app_ffi.mjs", "mixin_cell")
fn mixin(o: JsObject) -> JsObject

fn properties() -> JsObject {
  [
    component.BooleanProperty("hover", False),
    component.BooleanProperty("link", False),
    component.StringProperty("extClass", ""),
    component.StringProperty("iconClass", ""),
    component.StringProperty("bodyClass", ""),
    component.StringProperty("icon", ""),
    component.StringProperty("title", ""),
    component.StringProperty("value", ""),
    component.BooleanProperty("showError", False),
    component.StringProperty("prop", ""),
    component.StringProperty("url", ""),
    component.StringProperty("footerClass", ""),
    component.StringProperty("footer", ""),
    component.BooleanProperty("inline", True),
    component.BooleanProperty("hasHeader", True),
    component.BooleanProperty("hasFooter", True),
    component.BooleanProperty("hasBody", True),
    component.StringProperty("extHoverClass", ""),
    component.StringProperty("ariaRole", ""),
  ]
  |> component.to_properties()
}

fn relations() -> JsObject {
  let a = object.new() |> object.set("type", "ancestor")
  object.new()
  |> object.set("../form/form", a)
  |> object.set("../cells/cells", a)
}

fn set_error(m: String) -> Nil {
  let cp = page.current_page()
  let e = object.literal([#("error", m)])
  page.set_data(cp, e, fn() { Nil })
  |> util.drain
}

fn set_outer_class(c: String) -> Nil {
  let cp = page.current_page()
  let oc = object.literal([#("outerClass", c)])
  page.set_data(cp, oc, fn() { Nil })
  |> util.drain
}

fn set_in_form() -> Nil {
  let cp = page.current_page()
  let f = object.literal([#("inForm", True)])
  page.set_data(cp, f, fn() { Nil })
  |> util.drain
}

fn navigate_to() -> Nil {
  let r = {
    use data <- result.try(page.get_data(0))
    use url <- result.try(object.field(data, "url", decode.string))
    Ok({
      use res <- promise.try_await(base.navigate_to(url, fn() { Nil }))
      component.trigger_self_event("navigatesuccess", res, object.new())
    })
  }

  {
    use r0 <- promise.map(util.flatten(r))
    result.map_error(r0, fn(e) {
      let error = object.literal([#("error", e)])
      component.trigger_self_event("navigateerror", error, object.new())
    })
  }
  |> util.drain
}

fn methods() -> JsObject {
  object.new()
  |> object.set("setError", set_error)
  |> object.set("setInForm", set_in_form)
  |> object.set("setOuterClass", set_outer_class)
}

pub fn component() -> JsObject {
    object.new()
    |> object.mutate("options.mutipleSlots", True)
    |> object.mutate("data.inForm", False)
    |> object.set("methods", methods())
    |> object.set("relations", relations())
    |> object.set("properties", properties())
    |> mixin
}
