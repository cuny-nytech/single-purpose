To run this app you need 'sinatra' and 'nokogiri'.  You can build it locally with sinatra or heroku.

This app has two purposes.  The first purpose is that it will stream a random traffic camera from NYC.  The stream also
functions as a link to another random traffic camera stream.  The tail end of the url is the number of the traffic camera.  If you want to find the number of a specific camera, see : http://nyctmc.org/.

The second purpose is that the app tell's you the weather in NYC.  It reads an xml file from noaa.gov and just gives you the a no frills presentation of the weather.  To access the weather from the streaming portion, there is a link in the upper left hand corner.
