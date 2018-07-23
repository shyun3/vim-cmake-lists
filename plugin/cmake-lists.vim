function! s:CMakeListsOpen(force)
  let fname = expand('%:p')
  if !filereadable(fname) | return | endif

  let listname = expand('%:p:h') . '/CMakeLists.txt'
  if !a:force && !filereadable(listname)
    echo 'CMakeLists file not found in current directory'
    return
  endif

  execute 'edit' listname
endfunction

command! -bang CMakeLists call <SID>CMakeListsOpen(<bang>0)
