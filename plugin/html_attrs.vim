" html_attrs.vim
" Author: Trabe Soluciones, S.L.
" Version: 0.0.2

if exists("g:loaded_html_attrs")
  finish
endif
let g:loaded_html_attrs = 1

if !exists('g:html_attrs_remove_existing_id')
  let g:html_attrs_remove_existing_id = 0
endif

function! s:SaveState()
  let s:state_l      = getpos(".")
  let s:state_vstart = getpos("'<")
  let s:state_vend   = getpos("'>")
endfunction

function! s:RestoreState(restoreLine)
  call setpos("'<", s:state_vstart)
  call setpos("'>", s:state_vend)

  if a:restoreLine
    call setpos(".", s:state_l)
  endif
endfunction

function! s:SearchForOpeningTag()
  "visual select the current tag
  execute "normal! vat\<esc>"
  let l:pos = getpos("'<")

  return l:pos[1:2]
endfunction

function! s:AddAttr(attr_name, replace)
  call s:SaveState()
  let l:opening = s:SearchForOpeningTag()

  if !(l:opening[0] ==# 0)
    call cursor(l:opening)
    let l:attr = search(" ".a:attr_name."=\"", "e", line('.')) "search for the attr
    "TODO search not only in the current line but within the whole opening tag

    if l:attr ==# 0
      "no match, insert the attribute
      execute "normal! ea ".a:attr_name."=\"\""
    else
      "found it!
      call cursor(l:attr)

      if a:replace
        normal! di"
      else
        normal! l
      endif
    endif
    :startinsert
    call s:RestoreState(false)
  else
    call s:RestoreState(true)
  endif
endfunction

function! s:AddId()
  call s:AddAttr('id', g:html_attrs_remove_existing_id)
endfunction

function! s:AddClass()
  call s:AddAttr('class', 0)
endfunction

command! HtmlAttrsAddId :call s:AddId()
command! HtmlAttrsAddClass :call s:AddClass()
