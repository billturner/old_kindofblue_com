$(document).ready ->
  $("a.fancybox").fancybox
    closeClick: true
    closeBtn: true
    loop: false
    nextEffect: "none"
    prevEffect: "none"
    keys:
      close: [27]
    helpers:
      title:
        type: "inside"
