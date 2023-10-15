# open_weather_bloc_project


## Introductions

The Weather Check App is a Flutter application designed to provide real-time weather information for cities worldwide using the OpenWeatherMap API. This app was created as part of a college project to demonstrate the use of the BLoC (Business Logic Component) architecture, as well as to explore various packages to enhance its functionality.

# Features

City Temperature Check: Users can enter the names of cities to check the current temperature and weather conditions.

OpenWeatherMap API Integration: The app utilizes the OpenWeatherMap API to fetch weather data for the specified cities.

# Packages

Environmental Variables with flutter_dotenv: Sensitive information, such as API keys, is securely managed using the flutter_dotenv package. This allows for easy configuration of the app without exposing confidential data in the source code.

State Management with flutter_bloc: The app leverages the power of the flutter_bloc package to manage the application's state effectively, making it easy to update and display weather information based on user input.

HTTP Requests with http and Data Retrieval with get: The app uses the http package for making HTTP requests to the OpenWeatherMap API and the get package for handling data retrieval and processing.

Testing with bloc_test and mocktail: All app functionalities are rigorously tested using the bloc_test and mocktail packages, ensuring the stability and reliability of the application.

A few resources to get you started if this is your first Flutter project:

Create a .env file in the root directory of the project to store your OpenWeatherMap API key. Add your API key as follows:
    
    OPENWEATHERMAP_API_KEY=your_api_key_here

# Testing

    flutter test

Inline Link:
To create an inline link, use square brackets for the link text and parentheses for the URL.
[OpenWeatherMap API](https://www.openweathermap.org/)
