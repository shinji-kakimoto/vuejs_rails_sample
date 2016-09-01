$ ->
	demo = new Vue(
			el: "#demo"
			data:
				name: "私"
			methods:
				execute: ->
					@message = "実行しました"
					return
		)

	return
