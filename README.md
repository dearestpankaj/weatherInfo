# weather_info_app

The application fetches weather forecast for user location from openweathermap.org.

I have used following api for the app:
api.openweathermap.org/data/2.5/forecast?lat=52.521992&units=metric&lon=13.413244&APPID=a8c0e93e777048dab07f22418b2a6795

The above api provides weather forecast for next 5 days but for every 3 hours. I could not find another free api that could give me daily weather information.
So I used this api and filtered for first data of every day and displayed it to the user.


<img src="https://![Simulator Screenshot - iPhone 15 Pro - 2024-03-04 at 13 51 44](https://github.com/dearestpankaj/weatherInfo/assets/987922/5aad6458-1db3-4560-b2a1-ae04855c8fed)
github.com/dearestpankaj/weatherInfo/assets/987922/b23985f6-cda2-49e6-aa08-ad374a6bbabc" width=50% height=50%>

<img src="https://github.com/dearestpankaj/weatherInfo/assets/987922/a5ddbae6-40c1-4cae-9a7f-acc6e2f96200" width=50% height=50%>



## Architecture

Application is build with bloc architecture and uses clean architecture with it to provide benefits of layered architecture and more closely follow SOLID principals.

An overview of clean architecture:

<img width="484" alt="Clean_Arch" src="https://github.com/dearestpankaj/weatherInfo/assets/987922/d340138e-bea2-4eb1-b32b-ad94ea3a3b4f">
