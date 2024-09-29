# Image Search App
A SwiftUI application that allows users to search for images based on color tags, orientation, and logical operators. The app demonstrates advanced search functionality, including support for multiple colors, orientation filters, and the "OR" operator.

App Requirements 

1. Create a function that fetches the data from http://frontendtest.jobs.fastmail.com.user.fm/data.json and outputs a list of the name properties of each object.

2. Add a search argument to the function. This is a string. If supplied, only output the name of objects with a colour matching the string. (Step 1 & 2 are in branch feature/step2)

3. Modify the function so the search argument can be a string with multiple colour names, e.g. "red white". An object must have all given colours to match. (in branch feature/step3)

4. Add support for "is:portrait" and "is:landscape" keywords, to only return the names of objects that represent portrait or landscape images respectively. These keywords can be used in combination with the colour names to filter, e.g. "red is:portrait". (in branch feature/step4)

5. Add support for the "OR" operator, e.g. "red OR white is:portrait" to return the names of objects that match any of the given conditions. (in branch feature/step5)


## Installation 

1. Clone the Repository:
2. Navigate to the project directory.
3. Open codeTest.xcodeproj
4. Press Command + R or click the Run button to build and run the app.


![simulator_screenshot_4D90ADBA-CB58-4155-9B1E-6850C20C5C14](https://github.com/user-attachments/assets/de989929-4f97-4f1c-a34d-3351534ecd43)
It loads all images as default and 
You can enter your search query in the search bar. 

## Project Structure

#Model:
ImageData: Represents an image with properties like name, tags, width, and height.
ImageResponse: Contains the imagePath and an array of ImageData.

#ViewModel:
SearchImageViewModel: Handles the business logic, including data fetching and filtering based on search criteria.

#View:
ContentView: The main user interface where users can input search terms and view results.

#Data Source:
ImageDataSource: Protocol defining the data fetching method.
ImageDataSourceImpl: Implementation of ImageDataSource that fetches data from a JSON endpoint.

#Networking:
RequestManager and NetworkManager: Handle network requests.

#Unit Tests: codeTestTests.swift
Comprehensive tests covering various filtering scenarios and ensuring the ViewModel behaves as expected.

