jQuery ->

  jQuery.support.cors = true;

  index = 1
  length = 21
  mediaNature = 'IMAGE'
  server = ''
  token = ''
  
  pollCount = 0

  dynamo_config_url = "/connection"
  
  poll = ->
    setTimeout getData, 5000

  getConfig = ->
    request = $.ajax dynamo_config_url,
      type: 'GET'
      dataType: 'xml'
      error: (jqXHR, textStatus, errorThrown) ->
        $('#dynamo-loading').text "Problem loading config: #{errorThrown}."
      success: (data, textStatus, jqXHR) ->
        
        server = $(data).find("config > server").attr("href")
        token = $(data).find("config > token").text()

        $('#dynamo-loading').text "Loading data..."
        getData()


  getData = ->    
    dynamo_api_url = "/data/#{token}"  
    request = $.ajax dynamo_api_url,
      type: 'GET'
      dataType: 'xml'
      error: (jqXHR, textStatus, errorThrown) ->
        $('#dynamo-loading').text "Problem loading data: #{errorThrown}.    #{dynamo_api_url}"
      success: (data, textStatus, jqXHR) ->
        processData data

  processData = (data) ->
    $('#dynamo-loading').text "Successfully loaded data #{pollCount + 1} times."
    for eachImage, i in $(data).find("image")
      original_url = $(eachImage).attr('urlOriginalFile')
      url = if i < 1 then $(eachImage).attr('url') else $(eachImage).attr('urlThumbnail')
      column = if i < 3 then 1 else if i < 7 then 2 else if i < 14 then 3 else 4
      if pollCount < 1
        $("#column_#{column}").append("<div id='item_#{i}'><a href='#{original_url}'><img id='image_#{i}' src='#{url}' /></a></div>")
      else
        unless url == $("#image_#{i}")[0].src
          $("#item_#{i} img").attr("src",url).stop(true,true).hide().fadeIn()
          $("#item_#{i} a").attr("href", "#{original_url}")

    pollCount += 1
    poll()

  getConfig()