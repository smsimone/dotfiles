--- https://www.reddit.com/r/neovim/comments/1gbbnsq/minimal_macro_plugin_in_11_lines/
vim.api.nvim_create_autocmd('RecordingLeave', {
	callback = function()
		if vim.v.event.regcontents ~= '' then
			vim.schedule_wrap(vim.notify)('Recorded macro: ' .. vim.fn.keytrans(vim.v.event.regcontents))
		else
			vim.schedule_wrap(vim.notify)('Empty macro, previous recoding is kept')
			vim.schedule_wrap(function(prev) vim.fn.setreg('q', prev) end)(vim.fn.getreg 'q')
		end
	end
})

vim.keymap.set('n', 'q', '(reg_recording()==""?"qq":"q")', { expr = true })
vim.keymap.set('n', 'Q', '(reg_recording()==""&&reg_executing()==""?":norm! @q\r":"")', { expr = true })
vim.keymap.set('n', 'cq',
	':let b:_t=input(">",keytrans(@q))|let @q=(trim(b:_t)!=""?nvim_replace_termcodes(b:_t,1,1,1):@q)\r')