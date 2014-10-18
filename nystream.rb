require 'sinatra'  # to make the website
require 'nokogiri' # to parse noaa.gov xml
require 'open-uri' # to search through xml file from the web

# partial working traffic camera list
cameralist = '461 465 401 586 582 701 540 673 502 247 261
  1 2 4 5 7 9 10 12 14 15 16 18 19 20 22 25 28 31 33 35 36
  38 42 43 44 48 49 50 53 55 56 57 58 64 65 66 67 68 69 71
  72 74 83 84 90 96 98 102 103 106 111 122 134 144 146 148
  149 171 191 198 369 368 361 360 371 363 365 366 367 390
  328 263 476 191 403 398 410 399 400 409 408 170 414 416
  420 359 178 172 187 421 445 434 166 329 188 185 186 437
  436 183 162 189 157 413 412 404 405 285 406 411 287 466
  446 419 426 427 320 344 438 441 338 462 464 433 432 431
  322 138 386 384 428 439 440 395 425 424 453 457 458 460
  454 668 666 688 689 251 686 128 692 656 253 455 321 194
  327 318 201 508 697 696 203 277 302 391 443 383 448 396
  450 281 143 120 337 323 238 415 316 315 127 372 314 290
  402 289 299 213 324 303 286 259 358 397 475 254 258 305
  340 400'.split(' ').map(&:to_i)

get '/' do
  @nextcam = cameralist.sample
  erb :home
end

get '/weather' do
  # checks noaa.gov for weather
  @nextcam = cameralist.sample
  @wdoc = Nokogiri::XML(open('http://forecast.weather.gov' \
  '/MapClick.php?lat=40.71980&lon=-73.993&unit=0&lg=engli' \
  'sh&FcstType=dwml'))
  @wcondstr = @wdoc.xpath("//data[@type='current observations']" \
  '//weather-conditions').first.attr('weather-summary')
  @temp = @wdoc.xpath("//data[@type='current observations']" \
  '//value').first.child.to_s
  erb :weather, layout: :weather
end

# streaming page, looks at current camera
get '/:currentcam' do
  @currentcam = params[:currentcam]
  @nextcam = cameralist.sample
  erb :stream2
end
