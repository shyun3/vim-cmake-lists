"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Main functions

function! s:CMakeListsOpen(force, ...)
  if a:0 > 1
    echoerr 'Can only take 0 or 1 extra arguments'
    return
  endif

  " Check if current buffer is a valid file (e.g. not quickfix list, etc.)
  let invalidDirMsg = 'Directory is not valid for CMakeLists files'
  if !filereadable(expand('%:p'))
    echo invalidDirMsg
    return
  endif

  " Use current directory if directory argument was not passed
  let dir = a:0 ? s:GetFullPath(a:1) : s:GetCurrFileDir()
  if !isdirectory(dir)
    echo invalidDirMsg
    return
  endif

  if a:force || s:IsCMakeListsInDir(dir)
    execute 'edit' s:AppendCMakeListsToDir(dir)
  endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Utilities

function! s:IsCMakeListsInDir(dir)
  let listname = s:AppendCMakeListsToDir(a:dir)
  if !filereadable(listname)
    echo 'CMakeLists file not found in directory'
    return 0
  endif

  return 1
endfunction

function! s:AppendCMakeListsToDir(dir)
  return a:dir . '/CMakeLists.txt'
endfunction

" For relative directories, return the full directory path relative to the
" current file directory. For absolute directories, return without
" modifications. Return empty string if the argument is an invalid directory.
function! s:GetFullPath(dir)
  let fullPath = s:GetCurrFileDir() . '/' . a:dir
  if !isdirectory(fullPath)
    " Assume argument was absolute path
    return isdirectory(a:dir) ? a:dir : ''
  else
    return fullPath
  endif
endfunction

function! s:GetCurrFileDir()
  return expand('%:p:h')
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" User commands

command! -bang -nargs=? -complete=dir CMakeLists
  \ call <SID>CMakeListsOpen(<bang>0, <f-args>)
command! -bang -complete=dir CMakeListsUp
  \ call <SID>CMakeListsOpen(<bang>0, '..')

autocmd FileType cmake nmap <buffer> gf :CMakeLists <cfile><CR>
