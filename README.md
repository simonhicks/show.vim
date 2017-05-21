# show.vim

show.vim is a utility library for vimscript that exposes the `show#show(buffer_name, content)`
function, which can be used to display programatically generated content in a read-only buffer.

This is useful for displaying the result of a query, of evaluating a file or of some other user
initiated background action. If a buffer already exists with the given name, it will be reused.
