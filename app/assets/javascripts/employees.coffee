$ ->
  Vue.component "employee-row",
    template: "#employee-row"
    props: employee: Object
    data: ->
      {
        editMode: false
        errors: {}
      }
    methods:
      #管理者/一般を切り替え、Employeeを更新
      toggleManagerStatus: ->
        @employee.manager = !@employee.manager
        @updateEmployee()
      updateEmployee: ->
        $.ajax
          method: 'PATCH'
          data: employee: @employee
          url: '/employees/' + @employee.id + '.json'
          success: (res) =>
            @errors = {}
            @employee = res
            @editMode = false
          error: (res) =>
            @errors = res.responseJSON.errors
      fireEmployee: ->
        $.ajax
          method: 'DELETE'
          url: '/employees/' + @employee.id + '.json'
          success: (res) =>
            @$remove()

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
    methods:
      hireEmployee: ->
        $.ajax
          method: "POST"
          data: employee: @employee
          url: "/employees.json"
          success: (res) =>
            @employees.push(res)
            @employee = {}
            @errors = {}
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
      test: ->
        @email = "go!!" if @name > 5
  )
