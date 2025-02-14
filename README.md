
## 📌 Project Overview
This project is a Flutter-based mobile application that includes authentication, home screen, and notifications functionalities. It follows a clean architecture and utilizes BLoC (Business Logic Component) for state management.

## 🚀 State Management
The project uses BLoC (Business Logic Component) for efficient state management. It ensures:

Separation of UI and business logic

Predictable state changes

Better testability

The BLoC structure is implemented for authentication and home features:

Auth BLoC (auth_bloc, auth_event, auth_state)

Home BLoC (home_bloc, home_event, home_state)
## Architecture
This project follows the Clean Architecture pattern, which helps in organizing code into different layers for maintainability and scalability.
### Project Structure:
lib/  
│── core/              # Core configurations (routes, themes, etc.)  
│── data/              # Data layer (models, repositories, services)  
│   ├── models/        # Data models  
│   ├── repositories/  # Data sources and repositories  
│   ├── services/      # Notification & shared preferences services  
│── presentation/      # UI & State management  
│   ├── blocs/         # BLoC state management  
│   ├── screens/       # UI screens  
│   ├── widgets/       # Reusable UI components  
│── main.dart          # Entry point of the app  


## 📢 Features
✔ User Authentication Flow:

Mobile Number Screen  
OTP Verification Screen  
User Name Input Screen  

✔ State Management:  
Used BLoC for state management to handle UI updates efficiently  

✔ API Integration:  
Firebase Authentication  
Fetching user data  

✔ Navigation & Routing:  
Implemented Navigator 2.0 (if used)  
Managed routes using BLoC Events  

✔ UI/UX Considerations:  

Adaptive UI (Responsive on all devices)  
Clean & Minimal UI following Material Design Guidelines

✔ Notification Service:
Firebase Cloud Messaging (FCM) integrated  
Foreground Notifications handled using flutter_local_notifications  
Push Notification Click Handling  

✔ Hamburger Menu:  
profile screen   
Login/SignUp Screen 
##  Challenges Faced & Solutions

✅ Challenge: Firebase messaging error (FIS_AUTH_ERROR)
💡 Solution:

Cleared Firebase Installations
Enabled Firebase Installations API in Google Cloud Console
Implemented delayed token fetching
✅ Challenge: Handling Navigation in BLoC
💡 Solution: Used BlocConsumer to manage navigation logic
## How to Run the Project? (Setup Instructions)
🛠 Pre-requisites:  
Install Flutter SDK (Latest Version)  
Install Android Studio or VS Code  
Setup Firebase  
📌 Steps to Run the App:  
1️⃣ Clone the repository:  
git clone <https://github.com/yash-goswami23/oru_phones_assignment/>  
cd project-folder  
2️⃣ Install dependencies:  
flutter pub get  
3️⃣ Run the app:  
flutter run  
🚀 If you face issues with Firebase:
Ensure google-services.json is placed inside android/app/
Run flutter clean && flutter pub get
## Download Apk
https://docs.google.com/uc?export=download&id=1Bq574nsrWmM11HwzNPQqsGD8UiwtaJVA
## Screens Shorts
### Authenitication Screens
#### Mobile Number Screens
![Screenshot_1739525647](https://github.com/user-attachments/assets/e2a12af7-16e7-4b47-a41d-354828b186b8)

#### Mobile OTP Screens
![Screenshot_1739525700](https://github.com/user-attachments/assets/7f729558-2093-453c-a8a4-29f50defa8e2)

#### Mobile Name Screens 
![Screenshot_1739525712](https://github.com/user-attachments/assets/9c735b40-4e77-49b3-abcf-5bd8c921df5d)

#### Mobile Hamburger
![Screenshot_1739525722](https://github.com/user-attachments/assets/5086a685-f973-4ff8-a984-0c3cb9cc41da)

#### Mobile Hamburger user not login 
![Screenshot_1739526630](https://github.com/user-attachments/assets/81f7f919-630c-4bfe-9237-e5b2183806e1)

#### Home Screens 
![Screenshot_1739525770](https://github.com/user-attachments/assets/aa6f1879-c175-46d2-8ca2-b4e889a643ae)
![Screenshot_1739525797](https://github.com/user-attachments/assets/a71388bf-37e1-41c9-b68f-cf9349622c2d)
![Screenshot_1739525811](https://github.com/user-attachments/assets/67cfa049-8847-4821-8ba4-c76430da053a)
![Screenshot_1739525817](https://github.com/user-attachments/assets/067ed785-6fd7-4ce9-9b80-c9300a142470)

#### Video
https://github.com/user-attachments/assets/9ff43b82-9f15-44f3-b79b-2c94cf6ac106
