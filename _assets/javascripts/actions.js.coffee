$(document).ready ->
  $("#archive-tabs").on "click", "a", (e) ->
    e.preventDefault()
    $(this).tab "show"
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
