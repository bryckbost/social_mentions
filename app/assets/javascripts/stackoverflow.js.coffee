$(document).on "ready", ->
  if $(".stackoverlow-mentions").length
    name = $("h1").data("name")
    $.getJSON "http://api.stackoverflow.com/1.1/search?intitle=#{name}", (data) ->
      if data
        $.each data["questions"], (question) ->
          $(".stackoverlow-mentions").append("<li><a href=\"#{question['question_id']}\">#{question['title']}</li>")