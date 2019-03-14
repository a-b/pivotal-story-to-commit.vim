  function! PasteStoryLink()
    let l:clipboard = @*

    let l:pattern = '^\(#\|https:\/\/www\.pivotaltracker\.com\/story\/show\/\)\(\d\{9\}\).*'

    if l:clipboard =~# l:pattern
      let l:story_number = substitute(l:clipboard, l:pattern, '\2', '')
      let l:story_link = printf("[#%s](https://www.pivotaltracker.com/story/show/%s)", l:story_number, l:story_number)

      echom printf('Found pivotaltracker.io story #%s', l:story_number)
      call append(line('.'), l:story_link)
      call append(line('.'), '')
    else
      echom 'Copy pivotaltracker.io story link or id to the clipboard before commit'
    endif
  endfunction
