if exists("g:done_show_autoload")
  finish
endif
let g:done_show_autoload = 1

function! s:is_visible(bnum)
	let wnum = 1
	let max_wnum = winnr("$")
	while wnum <= max_wnum
		if winbufnr(wnum) == a:bnum
			return 1
		end
		let wnum += 1
	endwhile
	return 0
endfunction

function! s:create_buffer(buffer_name)
	execute "new " . a:buffer_name
	setlocal buftype=nofile
	setlocal bufhidden=hide
	setlocal noswapfile
	setlocal nomodifiable
endfunction

function! s:open_buffer(buffer_name)
	let bnum = bufnr(a:buffer_name)
	if bnum == -1
		call s:create_buffer(a:buffer_name)
	else
		if s:is_visible(bnum) == 0
			execute "sbuffer " . bnum
		else
			while bufnr('%') != bnum
				execute "norm! "
			endwhile
		endif
	endif
endfunction

" Displays the given content in a no-file, read-only buffer. Either creates a
" new buffer if none is available, or reuses one if there's already a buffer
" with the requested name.
"
" @arg  buffer_name  The name of the buffer to use.
" @arg  content      A list of strings to display in that buffer (one string
"                    per line).
function! show#show(buffer_name, content)
	call s:open_buffer(a:buffer_name)
	setlocal modifiable
	normal! ggVGd
	call append(0, a:content)
	setlocal nomodifiable
endfunction
