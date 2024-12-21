local M = {}
function M.setup(opts)
    if opts then
		vim.keymap.set("n", "<Leader>h", function()
			if opts.a then
			   print("hello, " .. opts.b)
			else
			   print("no fucking opts")
			end
		 end)
    else
        print("opts is nil or false!")
    end
end
return M