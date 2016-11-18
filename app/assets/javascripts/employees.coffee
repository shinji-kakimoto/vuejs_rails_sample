$ ->
  Vue.component "employee-row",
    template: "#employee-row"
    props: employee: Object
    data: ->
      {
        editMode: false
        errors: {}
        msg: @employee.name
      }
    methods:
      employee_name: ->
        @employee.name
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
      selectEmployee: ->
        @$dispatch('child-msg', @msg)
        # こっちはEmployeeの値が変わると、追従。
        # @$dispatch('child-msg', @employee_name())


  employees = new Vue(
    el: "#employees"
    data:
      select_name: undefined
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
    events:
      'child-msg': (msg) ->
        @select_name = msg
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
