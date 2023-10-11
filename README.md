# BookmarkCollection App

BookmarkCollection is an iOS application designed to help users organize and manage their favorite links efficiently. With a user-friendly interface, this app allows you to save and categorize your bookmarks for quick and easy access.

## Table of Contents

1. [About the App](#about-the-app)
2. [Project Structure](#project-structure)
3. [Dependencies](#dependencies)
4. [Getting Started](#getting-started)
5. [Core Data Model](#core-data-model)
6. [Features](#features)
7. [Demo](#demo)

## About the App

![](https://github.com/akhmetpekov/BookmarkCollection/blob/main/images/logo.png)

BookmarkCollection is a simple yet effective solution for managing your bookmarks on iOS devices. Whether you want to save important websites, articles, or references, this app has you covered with the following features:

- **Add Bookmarks**: Save links along with their titles, ensuring that you can easily identify and manage your bookmarks.

- **Delete Bookmarks**: Remove links from your collection that are no longer needed or relevant.

- **View and Open Bookmarks**: Access your bookmarks and open them in your device's default web browser.

- **Intuitive User Interface**: A clean and user-friendly interface designed to provide a pleasant user experience.

## Project Structure

The project is structured into the following folders, each serving a specific purpose:

- **Model**: The `LinkManager` class for handling bookmark operations using Core Data.

- **Controllers**: Contains the primary view controllers:
  - `MainView`: The main view for displaying and managing bookmarks.
  - `WelcomeView`: The initial welcome view for new users.
  - `NewBookmarkActionSheet`: The view for adding new bookmarks.

- **CustomViews**: Custom UI components like buttons, text fields, and cells used throughout the app.

- **Application**: Contains the `AppDelegate` and `SceneDelegate`, the entry points for the app.

## Dependencies

This project utilizes the following dependencies:

- [SnapKit](https://github.com/SnapKit/SnapKit): A powerful library for defining Auto Layout constraints programmatically.

- [IQKeyboardManagerSwift](https://github.com/hackiftekhar/IQKeyboardManager): A keyboard management library to enhance the user's keyboard experience.

## Getting Started

To run the bookmarkCollection app on your iOS device or simulator, follow these steps:

1. Clone this repository to your local machine.

2. Open the project in Xcode.

3. Build and run the project on your device or simulator.

```bash
git clone git@github.com:akhmetpekov/BookmarkCollection.git
```

## Core Data Model

bookmarkCollection uses Core Data for data storage. The Core Data model, named `BookmarkCollectionDataModel`, contains a single entity:

- **Link**: Represents a bookmarked link with two attributes:
  - `title` (String): The title or name of the bookmark.
  - `url` (String): The URL of the bookmarked webpage.

## Features

- **Bookmark Management**: Easily add, delete, and organize your bookmarks.
  
- **User-Friendly Design**: The app offers an intuitive and visually appealing user interface.
  
- **Keyboard Management**: The app intelligently handles the keyboard to ensure a smooth experience.

## Demo

![](https://github.com/akhmetpekov/BookmarkCollection/blob/main/images/Demo.gif)


