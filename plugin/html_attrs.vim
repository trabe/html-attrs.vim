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
  execute "normal! \<esc>"
endfunction

function! s:SearchForOpeningTag()
  "visual select the current tag
  call setpos("'<", [0,0,0,0])
  call setpos("'>", [0,0,0,0])

  execute "normal! vat\<esc>"
  let l:pos = getpos("'<")

  if l:pos[1] ==# 0
    return 0
  else
    return l:pos[1:2]
  endif
endfunction

function! s:SearchForOpeningTagEnd(openingLine)
  call cursor(a:openingLine)
  let l:end = search(">", "eW")

  if l:end ==# 0
    return line('.')
  else
    return l:end
  end
endfunction

function! s:AddAttr(attr_name, replace)
  call s:SaveState()
  let l:opening = s:SearchForOpeningTag()

  if !(l:opening[0] ==# 0)
    let l:openingEnd = s:SearchForOpeningTagEnd(l:opening)
    call cursor(l:opening)

    "search for the attr
    let l:attr = search(" ".a:attr_name."=\"", "eW", l:openingEnd)

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
    call s:RestoreState(0)
  else
    call s:RestoreState(1)
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
