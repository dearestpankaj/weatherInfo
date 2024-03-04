# weather_info_app

The application fetches weather forecast for user location from openweathermap.org.

I have used following api for the app:
api.openweathermap.org/data/2.5/forecast?lat=52.521992&units=metric&lon=13.413244&APPID=a8c0e93e777048dab07f22418b2a6795

The above api provides weather forecast for next 5 days but for every 3 hours. I could not find another free api that could give me daily weather information.
So I used this api and filtered for first data of every day and displayed it to the user.

Screenshots:

![Simulator Screenshot - iPhone 15 Pro - 2024-03-04 at 13 51 44](https://github.com/dearestpankaj/weatherInfo/assets/987922/50b74235-07d1-45fc-8ccf-3b77d96f07cd)
![Simulator Screenshot - iPhone 15 Pro - 2024-03-04 at 13 48 59](https://github.com/dearestpankaj/weatherInfo/assets/987922/a4757fad-24bb-4dc2-9366-836757a7d9b7)
![Simulator Screenshot - iPhone 15 Pro - 2024-03-04 at 13 48 53](https://github.com/dearestpankaj/weatherInfo/assets/987922/391fbe1c-f19e-4986-85a2-68c0788b14a8)


## Architecture

Application is build with bloc architecture and uses clean architecture with it to provide benefits of layered architecture and more closely follow SOLID principals.

An overview of clean architecture:

<img width="484" alt="Clean_Arch" src="https://github.com/dearestpankaj/weatherInfo/assets/987922/d340138e-bea2-4eb1-b32b-ad94ea3a3b4f">
