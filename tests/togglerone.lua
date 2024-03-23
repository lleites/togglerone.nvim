local mock = require("luassert.mock")
local stub = require("luassert.stub")
local spy = require("luassert.spy")
local t = require("togglerone")
describe("Main tests", function()
	it("Registers toggle", function()
		local toogle_func = t.toggle_map("pwd", "ls")
		toogle_func()
		assert.equals(1, #t.toggles)
		assert.equals(true, t.toggles[1])
	end)

	it("Run right commands", function()
		local api = mock(vim.api, true)
		api.nvim_command.returns(nil)

		local toogle_func = t.toggle_map("Command1", "Command2")
		toogle_func()
		assert.stub(api.nvim_command).was.called_with("Command1")

		toogle_func()
		assert.stub(api.nvim_command).was.called_with("Command2")

		toogle_func()
		assert.stub(api.nvim_command).was.called_with("Command1")

		mock.revert(api)
	end)
	it("Run right functions", function()
		local var_1 = false
		local var_2 = false
		local func_1 = function()
			var_1 = true
		end
		local func_2 = function()
			var_2 = true
		end

		local toogle_func = t.toggle_map(func_1, func_2)
		toogle_func()
		assert.equals(var_1, true)
		toogle_func()
		assert.equals(var_2, true)
	end)
end)
