import { Ok, Error } from "./gleam.mjs"

export function generic_decoder(data) {
    return new Ok(data)
}

export function mixin_cell(o) {
    o["methods"]["navigateTo"] = function() { 
      // console.log(this)
      if (this.data.url && this.data.link) {
          wx.navigateTo({
              url: this.data.url,
              success: (res) => {
                  this.triggerEvent('navigatesuccess', res, {})
              },
              fail: (fail) => {
                  this.triggerEvent('navigateerror', fail, {})
              }
          })
      }
    }.bind(o)
    return o
}

