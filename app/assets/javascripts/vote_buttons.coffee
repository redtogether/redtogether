ready = ->
  vote_buttons = $("input.vote-button")

  vote_buttons.click (evt) ->
    evt.preventDefault()

    if not gon.current_user
      return alert "Must be logged in to vote"

    $button = $(this)
    $buttonTwin = $button.parent().siblings("form").find("input[type=submit]")
    $scoreCounter = $button.closest("article.post").find(".score")

    form = this.form

    $.ajax
      url: form.action,
      method: "put",
      dataType: "json"

    .done (res) ->
      swapButtonMeanings $button, $buttonTwin, $scoreCounter, res.links

swapButtonMeanings = ($button, $buttonTwin, $scoreCounter, links) ->
  buttonRel = $button.attr("rel")
  twinRel = $buttonTwin.attr("rel")

  score = parseInt($scoreCounter.html())

  switch buttonRel

    when "upvote"
      makeButtonUnvote $button, links
      makeButtonDownvote $buttonTwin, links if twinRel is "unvote"

      score += 1

    when "downvote"
      makeButtonUnvote $button, links
      makeButtonUpvote $buttonTwin, links if twinRel is "unvote"

      score -= 1

    when "unvote"
      if twinRel is "upvote"
        makeButtonDownvote $button, links

        score += 1
      else
        makeButtonUpvote $button, links

        score -= 1

  $scoreCounter.html(score)

makeButtonUnvote = ($button, links) ->
  $button.attr "value", "○"
  $button.attr "rel", "unvote"
  $button.closest("form").attr "action", links.unvote

makeButtonDownvote = ($button, links) ->
  $button.attr "value", "↓"
  $button.attr "rel", "downvote"
  $button.closest("form").attr "action", links.downvote

makeButtonUpvote = ($button, links) ->
  $button.attr "value", "↑"
  $button.attr "rel", "upvote"
  $button.closest("form").attr "action", links.upvote

$(document).ready(ready)
$(document).on("page:load", ready)