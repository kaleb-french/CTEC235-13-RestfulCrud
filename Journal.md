# Journal
Write your Journal questions and notes here.

Phase 0-
My first thoughts is the Interface and the api calls need seperation, the api calls could live in a class that could use streams or providor to hand out data from it. The Main page should have a listView with the albums the api returns in tiles with album data.
The biggest thing is first ironing out the api and checking the data it returns to consume it properly. Then worry about how the Interface will look aftwards.

Phase 1-
We created the basics of display and api for data for display in our listView on the main page of our app. The primary difference is how the JSON is structured in the response. you'll need to parse this json into a list if multiple items are returned.
