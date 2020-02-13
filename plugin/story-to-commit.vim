function! PasteStoryLink(...)

  if a:0
    let l:input = a:1
  else
    let l:input = @*
  endif


  let l:pattern = '^\([\?#\?\|https:\/\/www\.pivotaltracker\.com\/story\/show\/\)\(\d\{9\}\).*'

  if l:input =~# l:pattern
    echom "Input: " . l:input
    let l:story_number = substitute(l:input, l:pattern, '\2', '')
    let l:story_link = printf("[#%s](https://www.pivotaltracker.com/story/show/%s)", l:story_number, l:story_number)

    echom printf('Found https://www.pivotaltracker.com/story/show/%s', l:story_number)
    call append(line('.'), l:story_link)
    call append(line('.'), '')

  else

    let l:git_search_regex = '\[.*#[[:digit:]]{9}\.*]'

    let l:git_search_list = systemlist("git log -1 -E --grep='". shellescape(l:git_search_regex) . "'")
    let l:git_search_story_line = system("grep -E '" . shellescape(l:git_search_regex) . "'", systemlist("git log -1 -E --grep='". shellescape(l:git_search_regex) . "'"))

    let l:story_number = substitute(trim(l:git_search_story_line), l:pattern, '\2', '')

    echom printf('SEARCH RESULT: %s', l:git_search_list)
    echom printf('STORY NUMBER: %s', trim(l:story_number))

    call append(line('.'), printf("#\t %s", repeat("=", 60)))

    " call append(line('.'), map(l:git_search_list, '" " . trim(printf("#" . repeat("\t", 1) . v:val))'))

    call append(line('.'), printf("#\t %s", repeat("=", 60)))
    call append(line('.'), printf("#\t".'THIS FEATURE IS EXPERIMENTAL, PLEASE PROVIDE YOUR FEEDBACK TO AB'))
    call append(line('.'), printf("#\t %s", repeat("^", 60)))

    let l:story_link = printf("#[#%s](https://www.pivotaltracker.com/story/show/%s)", l:story_number, l:story_number)

    echom printf('Found https://www.pivotaltracker.com/story/show/%s', l:story_number)
    call append(line('.'), '')
    call append(line('.'), l:story_link)
    call append(line('.'), '# The story ID below was parsed from git history')
    call append(line('.'), '')

    echom 'Copy pivotaltracker.io story link or id to the clipboard before commit'
  endif
endfunction

command! -nargs=? P2Story call PasteStoryLink(<f-args>)



