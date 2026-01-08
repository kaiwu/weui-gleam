import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/io
import gleam/javascript/promise
import gleam/javascript/array
import gleam/list
import gleam/result

import wechat/app
import wechat/base
import wechat/object.{type JsObject}
import wechat/page

type Block {
  Block(id: String, name: String, open: Bool, pages: List(String))
}

@external(javascript, "../../../app_ffi.mjs", "generic_decoder")
fn block_from_dynamic(d: Dynamic) -> Result(Block, Block)

fn init() -> JsObject {
  object.new()
  |> object.set("list", array.from_list([
    Block(id: "form", name: "表单", open: False, pages: [
      "cell",
      "slideview",
      "form",
      "uploader",
    ]),
    Block(id: "widget", name: "基础组件", open: False, pages: [
      "article",
      "icons",
      "badge",
      "flex",
      "footer",
      "gallery",
      "grid",
      "loadmore",
      "loading",
      "panel",
      "preview",
    ]),
    Block(id: "feedback", name: "操作反馈", open: False, pages: [
      "dialog",
      "msg",
      "half-screen-dialog",
      "actionsheet",
      "toptips",
    ]),
    Block(id: "nav", name: "导航相关", open: False, pages: ["navigation", "tabbar"]),
    Block(id: "search", name: "搜索相关", open: False, pages: ["searchbar"]),
  ]))
}

fn on_show() -> Nil {
  let _ =
    app.get_app()
    |> object.get("set_theme")
    |> result.try(object.call(_, "index"))
  Nil
}

fn kind_toggle(e: JsObject) -> Nil {
  let r = {
    use oid <- result.try(object.path_field(
      e,
      "currentTarget.id",
      decode.string,
    ))
    use data <- result.try(page.get_data(0))
    let decoder = decode.new_primitive_decoder("Block", block_from_dynamic)
    use block_list <- result.try(object.field(
      data,
      "list",
      decode.list(decoder),
    ))
    list.try_fold(block_list, [], fn(ls, b) {
      let b0 = Block(..b, open: !b.open)
      let b1 = Block(..b, open: False)
      let ns = case b.id {
        id if id == oid -> list.append(ls, [b0])
        _ -> list.append(ls, [b1])
      }
      Ok(ns)
    })
  }
  case r {
    Ok(bs) -> {
      let cp = page.current_page()
      let ls = object.literal([#("list", array.from_list(bs))])
      let _ = page.set_data(cp, ls, fn() { io.println("toggle kind done") })
      Nil
    }
    Error(error) ->
      case error {
        object.WechatError(m) -> io.println(m)
        _ -> io.println("toggle kind error")
      }
  }
}

fn open_page(e: JsObject) -> Nil {
  let _ = {
    use p <- promise.try_await(
      promise.resolve(object.path_field(
        e,
        "currentTarget.dataset.page",
        decode.string,
      )),
    )
    let dest = "pages/" <> p <> "/" <> p
    base.navigate_to(dest, fn() { io.println("navigated to " <> p) })
  }
  Nil
}

pub fn page() -> JsObject {
  object.literal([
    #("openPage", open_page),
    #("kindToggle", kind_toggle),
  ])
  |> object.set("onShow", on_show)
  |> object.set("data", init())
}
