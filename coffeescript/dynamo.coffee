jQuery ->

  index = 1
  length = 21
  mediaNature = 'IMAGE'
  server = 'memory-life.com'
  token = '97be50d4-80c8-422b-b91f-53c5ce5d0020'
  
  pollCount = 0

  dynamo_config_url = "http://rmn.memory-life.com/Connect/?msidn=prod"
  dynamo_api_url = "http://api.#{server}/v2.0/?method=ml.account.medias.list&token=#{token}&index=#{index}&length=#{length}&mediaNature=#{mediaNature}"
  


  # Problem with CORS for this request right now so using default server & token
  getConfig = ->
    request = $.get "http://rmn.memory-life.com/Connect/?msidn=prod"
    request.done (data) -> getData data
    request.fail (jqXHR, textStatus, errorThrown) -> $('#dynamo-loading').text "Problem loading config: #{errorThrown}."

  # polling for updates every 5 seconds
  poll = ->
    setTimeout getData, 5000

  # use this directly for now with token...
  getData = ->    
    request = $.get dynamo_api_url
    request.done (data) -> processData data
    request.fail (jqXHR, textStatus, errorThrown) -> $('#dynamo-loading').text "Problem loading data: #{errorThrown}."

  processData = (data) ->
    pollCount += 1
    $('#dynamo-loading').text "Successfully loaded data #{pollCount} times."

    $("#column_1, #column_2, #column_3, #column_4").empty()
    for eachImage, i in $(data).find("image")
      url = if i < 1 then $(eachImage).attr('url') else $(eachImage).attr('urlThumbnail')
      column = if i < 3 then 1 else if i < 7 then 2 else if i < 14 then 3 else 4
      $("#column_#{column}").append("<div><img id='id_#{i}' src='#{url}' /></div>")
    poll()

  getData()

  




