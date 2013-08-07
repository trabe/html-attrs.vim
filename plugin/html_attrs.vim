" html_attrs.vim
" Author: Trabe Soluciones, S.L.
" Version: 0.0.1

if exists("g:loaded_html_attrs")
  finish
endif
let g:loaded_html_attrs = 1

if !exists('g:html_attrs_remove_existing_id')
  let g:html_attrs_remove_existing_id = 0
endif

function! s:HtmlAttrsAddAttr(attr_name, replace)
  let l:opening = search("<[^/>][^>]*>", "b") "search for opening tag

  if !(l:opening ==# 0)
    call cursor(l:opening)
    let l:attr = search(" ".a:attr_name."=\"", "e", line('.')) "search for the attr
    "TODO search not only in the curren line but within the whole opening tag

    if l:attr ==# 0
      "no match, insert the attribute
      :execute "normal! ea ".a:attr_name."=\"\""
    else
      "found it!
      call cursor(l:attr)

      if a:replace
        :normal! di"
      else
        :normal! l
      endif
    endif
    :startinsert
  endif
endfunction

function! s:HtmlAttrsAddId()
  call s:HtmlAttrsAddAttr('id', g:html_attrs_remove_existing_id)
endfunction

function! s:HtmlAttrsAddClass()
  call s:HtmlAttrsAddAttr('class', 0)
endfunction

command! HtmlAttrsAddId :call s:HtmlAttrsAddId()
command! HtmlAttrsAddClass :call s:HtmlAttrsAddClass()
