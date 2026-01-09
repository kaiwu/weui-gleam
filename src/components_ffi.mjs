import { Ok, Error } from "./gleam.mjs"

export function mixin_cell_methods(o) {
    o["methods"] = {
        setError(error) {
            this.setData({
                error: error || false
            })
        },
        setInForm() {
            this.setData({
                inForm: true
            })
        },
        setOuterClass(className) {
            this.setData({
                outerClass: className
            })
        },
        navigateTo() {
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
        }
    }
    return o
}

