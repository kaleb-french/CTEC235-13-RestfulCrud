# Journal
Write your Journal questions and notes here.

Phase 0-
My first thoughts is the Interface and the api calls need seperation, the api calls could live in a class that could use streams or providor to hand out data from it. The Main page should have a listView with the albums the api returns in tiles with album data.
The biggest thing is first ironing out the api and checking the data it returns to consume it properly. Then worry about how the Interface will look aftwards.

Phase 1-
We created the basics of display and api for data for display in our listView on the main page of our app. The primary difference is how the JSON is structured in the response. you'll need to parse this json into a list if multiple items are returned.

Phase 2-
I added the ability to click the albums and have a details show above via a nullable variable that defaults to "no album available." This approach changes the page look based on an updated variable as opposed to moving to a new page with new content.

Phase 3-
Added delete functionality to the details area by adding a elevated button that sends a Delete object to the input sink with the id of album to delete. It's critial to get the status code becuase if it wasn't deleted then there will be no change.

Phase 4-
Ran through program a couple times and checked for errors. Had already reformatted a couple things to catch some errors.
