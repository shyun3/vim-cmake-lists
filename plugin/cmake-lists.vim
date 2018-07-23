function! s:CMakeListsOpen()
  let fname = expand('%:p')
  if !filereadable(fname) | return | endif

  let listname = expand('%:p:h') . '/CMakeLists.txt'
  if !filereadable(listname)
    echo 'CMakeLists file not found in current directory'
    return
  endif

  execute 'edit' listname
endfunction

command! CMakeLists call <SID>CMakeListsOpen()
