"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Main functions

function! s:CMakeListsOpen(force, dir)
  if !s:IsDirValid(a:dir) | return | endif
  if !a:force && !s:IsCMakeListsInDir(a:dir) | return | endif

  execute 'edit' s:AppendCMakeListsToDirName(a:dir)
endfunction

function! s:CMakeListsCurr(force)
  call s:CMakeListsOpen(a:force, expand('%:p:h'))
endfunction

function! s:CMakeListsParent(force)
  call s:CMakeListsOpen(a:force, expand('%:p:h:h'))
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Utilities

function! s:IsDirValid(dir)
  if !isdirectory(a:dir)
    echo 'Directory is not valid for CMakeLists files'
    return 0
  endif

  return 1
endfunction

function! s:IsCMakeListsInDir(dir)
  let listname = s:AppendCMakeListsToDirName(a:dir)
  if !filereadable(listname)
    echo 'CMakeLists file not found in directory'
    return 0
  endif

  return 1
endfunction

function! s:AppendCMakeListsToDirName(dir)
  return a:dir . '/CMakeLists.txt'
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" User Ex commands

command! -bang CMakeLists call <SID>CMakeListsCurr(<bang>0)
command! -bang CMakeListsUp call <SID>CMakeListsParent(<bang>0)
