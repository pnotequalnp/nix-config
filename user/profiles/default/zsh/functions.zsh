function realwhich() {
  realpath $(which ${1})
}

function storepath() {
  realwhich ${1} | xargs dirname | xargs dirname
}
