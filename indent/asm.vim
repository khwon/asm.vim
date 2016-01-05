if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

setlocal indentexpr=AsmIndent()

function! AsmIndent(...)
  let clnum = a:0 ? a:1 : v:lnum
  " first line => go first
  if clnum <= 1
    return 0
  endif

  " label or preprocessor => go first
  let line = getline(clnum)
  if line =~ ":[\t ]*$" || line =~ "^[\t ]*#"
    return 0
  endif

  if line =~ "^[\t ]*\\."
    return &tabstop
  endif

  " TODO : handle other cases
  let prev_num = prevnonblank(clnum - 1)
  let prev_line = getline(prev_num)
  if prev_line =~ ":$"
    return indent(prev_num) + &tabstop
  endif

  return &tabstop

endfunction
