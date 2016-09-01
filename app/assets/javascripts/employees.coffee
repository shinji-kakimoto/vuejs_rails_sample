$ ->
  employees = new Vue(
    el: "#employees"
    data:
      employees: []
    ready: ->
      that = undefined
      that = this
      $.ajax
        url: "/employees.json"
        success: (res) ->
          that.employees = res
          @employees = res
          return
  )

  demo = new Vue(
    el: "#demo"
    data:
      name: "私"
      email: "メール"
      message: "送りたい。"
    methods:
      execute: ->
        @message = "送信しました"
        return
  )
  return
