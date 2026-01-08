// import wechat/base
import wechat/component
import wechat/object.{type JsObject}
import wechat/page

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
  let _ = page.set_data(cp, e, fn() { Nil })
  Nil
}

fn set_outer_class(c: String) -> Nil {
  let cp = page.current_page()
  let oc = object.literal([#("outerClass", c)])
  let _ = page.set_data(cp, oc, fn() { Nil })
  Nil
}

fn set_in_form() -> Nil {
  let cp = page.current_page()
  let f = object.literal([#("inForm", True)])
  let _ = page.set_data(cp, f, fn() { Nil })
  Nil
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
  |> object.set("relations", relations())
  |> object.set("properties", properties())
  |> object.set("methods", methods())
}
