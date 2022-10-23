 vim.cmd([[
	augroup filetypedetect
  au! BufRead,BufNewFile *.mine                setfiletype mine
  au! BufRead,BufNewFile *.xyz                setfiletype drawing
augroup END
	  ]])


