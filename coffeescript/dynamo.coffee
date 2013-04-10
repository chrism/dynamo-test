jQuery ->

  jQuery.support.cors = true;

  index = 1
  length = 21
  mediaNature = 'IMAGE'
  server = ''
  token = ''
  
  pollCount = 0

  #dynamo_config_url = "http://rmn.memory-life.com/Connect/?msidn=prod"
  dynamo_config_url = "/connection"
  
  poll = ->
    setTimeout getData, 5000

  # needs sinatra to proxy for now because of JS security issue :()
  getConfig = ->
    request = $.ajax dynamo_config_url,
      type: 'GET'
      dataType: 'xml'
      error: (jqXHR, textStatus, errorThrown) ->
        $('#dynamo-loading').text "Problem loading config: #{errorThrown}."
      success: (data, textStatus, jqXHR) ->
        $('#dynamo-loading').text "Loading data..."
        server = $(data).find("config > server").attr("href")
        token = $(data).find("config > token").text()
        getData()


  getData = ->    
    dynamo_api_url = "http://api.#{server}/v2.0/?method=ml.account.medias.list&token=#{token}&index=#{index}&length=#{length}&mediaNature=#{mediaNature}"   
    request = $.ajax dynamo_api_url,
      type: 'GET'
      dataType: 'xml'
      error: (jqXHR, textStatus, errorThrown) ->
        $('#dynamo-loading').text "Problem loading data: #{errorThrown}."
      success: (data, textStatus, jqXHR) ->
        processData data

  processData = (data) ->

    console.log "is this XML? #{jQuery.isXMLDoc(data)}"
    pollCount += 1
    $('#dynamo-loading').text "Successfully loaded data #{pollCount} times."
    console.log data
    $("#column_1, #column_2, #column_3, #column_4").empty()
    for eachImage, i in $(data).find("image")
      #console.log $(eachImage).attr('urlOriginalFile')
      url = if i < 1 then $(eachImage).attr('url') else $(eachImage).attr('urlThumbnail')
      column = if i < 3 then 1 else if i < 7 then 2 else if i < 14 then 3 else 4
      $("#column_#{column}").append("<div><img id='id_#{i}' src='#{url}' /></div>")
    poll()

  getConfig()