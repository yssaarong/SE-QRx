# QRx

QRx is a web-based and mobile-friendly application designed to help users verify the authenticity of their medicines using QR codes. By simply scanning the QR code on a medicine’s packaging, QRx checks the product details against a trusted database to confirm if it’s genuine or potentially counterfeit. The project aims to promote safe medicine consumption and protect consumers from fake or unsafe pharmaceutical products.



## QRx Design Artifacts

UML Diagram:

<img src="images/qrx_uml.jpg" alt="QRx UML" width="600">

Class Diagram:

<img src="images/qrx_class_diagram.png" alt="QRx Class Diagram" width="600">

# Flutter App Setup and Installation Guide

**Repository URL:** [https://github.com/yssaarong/SE-QRx.git](https://github.com/yssaarong/SE-QRx.git)

This guide provides a complete, step-by-step process for running your Flutter app—whether on an Android emulator or a physical Android device.

---

## Requirements

Before running the project, ensure you have installed the following:

### 1. **Flutter SDK**

* Download from: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
* Extract and add Flutter to your system PATH.
* Verify installation:

```bash
flutter --version
```

### 2. **Android Studio**

Android Studio provides the Android SDK, emulator, and device tools.

* Download: [https://developer.android.com/studio](https://developer.android.com/studio)
* Install Android SDK and required tools.
* Ensure the following packages are installed via **SDK Manager**:

  * Android SDK Platform
  * Android SDK Build-Tools
  * Android Emulator
  * Android Platform Tools

### 3. **Device Setup**

You can run the app using either:

* Android Emulator
* Physical Android device

---

## Project Setup

Once dependencies are installed, follow these steps:

### 1. **Clone the GitHub Repository**

```bash
git clone https://github.com/your-username/your-repo.git
```

```bash
cd your-repo
```

### 2. **Install Flutter Packages**

Run the following command inside the project folder:

```bash
flutter pub get
```

This installs all dependencies from `pubspec.yaml`.

### 3. **Check Connected Devices**

To verify your emulator or phone is detected:

```bash
flutter devices
```

---

## Running on Android Emulator

### Step 1: Create a Virtual Device

1. Open **Android Studio**
2. Go to **AVD Manager**
3. Click **Create Virtual Device**
4. Choose a device model (e.g., Pixel 5)
5. Download a system image (e.g., Android 12)
6. Finish setup

### Step 2: Start the Emulator

* Open your created emulator from **AVD Manager**
* OR run:

```bash
flutter run --launch <emulator_id>
```

### Step 3: Run the Flutter App

```bash
flutter run -d <emulator_id>
```

---

## Running on a Physical Android Phone

### Step 1: Enable Developer Options

On your phone:

1. Settings → About Phone
2. Tap **Build Number** 7 times
3. Go back → Developer Options
4. Enable **USB debugging**

### Step 2: Install Device Drivers (Windows)

For Windows users:

* Install OEM USB drivers from your phone manufacturer

### Step 3: Connect Your Phone

Connect via USB cable, then verify:

```bash
flutter devices
```

Your device should appear.

### Step 4: Run the App

```bash
flutter run
```

---

## Troubleshooting

### **Flutter not detected in terminal**

Add Flutter to PATH:

* Windows: Edit System Environment Variables

### **Device not showing**

* Ensure USB debugging is on
* Try another cable or USB port
* Run:

```bash
adb devices
```

### **Android licenses issue**

Run:

```bash
flutter doctor --android-licenses
```

---

## Additional Useful Commands

| Command             | Description               |
| ------------------- | ------------------------- |
| `flutter doctor`    | Shows installation status |
| `flutter run -v`    | Verbose debugging run     |
| `flutter clean`     | Clears build cache        |
| `flutter build apk` | Builds an installable APK |

---

## You're Ready!

You should now be able to run, test, and develop on your Flutter app smoothly.


