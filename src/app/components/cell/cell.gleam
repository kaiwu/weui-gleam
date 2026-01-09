import wechat/component
import wechat/object.{type JsObject}

@external(javascript, "../../../components_ffi.mjs", "mixin_cell_methods")
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

pub fn component() -> JsObject {
  object.new()
  |> object.mutate("options.mutipleSlots", True)
  |> object.mutate("data.inForm", False)
  |> object.set("relations", relations())
  |> object.set("properties", properties())
  |> mixin
}
