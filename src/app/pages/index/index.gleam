import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/io
import gleam/javascript/array.{type Array}
import gleam/list
import gleam/result

import app/pages/common
import wechat/app
import wechat/object.{type JsObject}
import wechat/page
import wechat/util

type Block {
  Block(id: String, name: String, open: Bool, pages: Array(String))
}

@external(javascript, "../../../app_ffi.mjs", "generic_decoder")
fn block_from_dynamic(d: Dynamic) -> Result(Block, Block)

fn init() -> JsObject {
  object.new()
  |> object.set(
    "list",
    array.from_list([
      Block(
        id: "form",
        name: "表单",
        open: False,
        pages: array.from_list([
          "button",
          "form",
          "list",
          "slideview",
          "slider",
          "uploader",
        ]),
      ),
      Block(
        id: "layout",
        name: "基础组件",
        open: False,
        pages: array.from_list([
          "article",
          "badge",
          "flex",
          "footer",
          "gallery",
          "grid",
          "icons",
          "loading",
          "loadmore",
          "panel",
          "preview",
          "progress",
          "steps",
        ]),
      ),
      Block(
        id: "feedback",
        name: "操作反馈",
        open: False,
        pages: array.from_list([
          "actionsheet",
          "dialog",
          "half-screen-dialog",
          "msg",
          "picker",
          "toast",
          "information-bar",
        ]),
      ),
      Block(
        id: "nav",
        name: "导航相关",
        open: False,
        pages: array.from_list([
          "navigation-bar",
          "tabbar",
        ]),
      ),
      Block(
        id: "search",
        name: "搜索相关",
        open: False,
        pages: array.from_list(["searchbar"]),
      ),
    ]),
  )
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
      page.set_data(cp, ls, fn() { io.println("toggle kind done") })
      |> util.drain
    }
    Error(error) ->
      case error {
        object.WechatError(m) -> io.println(m)
        _ -> io.println("toggle kind error")
      }
  }
}

fn theme_toggle(_e: JsObject) -> Nil {
  {
    use t0 <- result.try({
      use t <- result.try(object.path_field(
        app.get_app(),
        "data.theme",
        decode.string,
      ))
      Ok(case t {
        "light" -> object.literal([#("theme", "dark")])
        _ -> object.literal([#("theme", "light")])
      })
    })
    common.change_theme(t0)
    Ok(common.set_theme())
  }
  |> util.drain
}

pub fn page() -> JsObject {
  object.literal([
    #("kindToggle", kind_toggle),
    #("changeTheme", theme_toggle),
  ])
  |> object.set("data", init())
}
