$ ->
  Vue.component "employee-row",
    template: "#employee-row"
    props: employee: Object


  employees = new Vue(
    el: "#employees"
    data:
      employees: []
      employee:
        name: ''
        email: ''
        manager: false
      errors: {}
    ready: ->
      $.ajax
        url: "/employees.json"
        success: (res) =>
          @employees = res
          return
    methods:
      hireEmployee: ->
        $.ajax
          method: "POST"
          data: employee: @employee
          url: "/employees.json"
          success: (res) =>
            @employees.push(res)
            @employee = {}
            @jrrors = {}
          error: =>
            @errors = res.responseJSON.errors
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
