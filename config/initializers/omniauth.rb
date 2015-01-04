Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '57uB8tZxjfhIpXRWx1eYwmOI9', 'x2sOO8T5y1VGG4WqpcdMcbBCJbD7Ogr1zP2dBXs5OycnPFy2iu' ,
  {:image_size => 'bigger'}
end
