# 📱 3D Scene Reconstruction with LiDAR

> A real-time iOS application that uses iPhone's LiDAR sensor to reconstruct 3D environments — scanning, visualizing, and exporting 3D models directly on-device with no cloud dependency.

![Swift](https://img.shields.io/badge/Swift-5.9-orange?style=flat-square&logo=swift)
![ARKit](https://img.shields.io/badge/ARKit-6.0-blue?style=flat-square)
![iOS](https://img.shields.io/badge/iOS-16%2B-black?style=flat-square&logo=apple)
![LiDAR](https://img.shields.io/badge/LiDAR-Required-red?style=flat-square)
![License](https://img.shields.io/badge/License-Open%20Source-green?style=flat-square)

---

## 🧠 About the Project

**Author:** Adnan Ansari — University ID: 22013278 / 03642477  
**Group:** 28 | Capstone Individual Report — March 26, 2025

This project builds an iOS-based computer vision application that transforms real-world physical environments into accurate 3D digital models using the iPhone Pro's LiDAR sensor. Built entirely on Apple's native frameworks — **Swift, ARKit, RealityKit, SwiftUI, and Metal** — the app performs all processing on-device with no internet or cloud required.

The goal is to democratize 3D modeling for students, architects, designers, and small organizations — particularly supporting cultural heritage preservation in Nepal's tourism and education sectors.

---

## ✨ Features

| Feature | Description |
|---|---|
| **Live LiDAR Scanning** | Real-time spatial scanning using ARKit scene reconstruction |
| **3D Mesh Generation** | Produces optimized point clouds and surface meshes on-device |
| **Real-Time Visualization** | Live wireframe/shaded mesh preview as you scan |
| **Noise Reduction** | Filters outliers and applies Laplacian smoothing to raw mesh data |
| **Multi-Format Export** | Export to OBJ, PLY, STL, and USDZ formats |
| **Surface Classification** | AI-powered labeling of walls, floors, ceilings, and furniture |
| **People Occlusion** | Filters moving people out of the scan using ARKit segmentation |
| **Role-Based Access** | Admin, Teacher, Student, Professional, and Demo user roles |
| **Offline Operation** | Fully on-device — no internet connection required |
| **Quick Look Preview** | Instant in-app preview of exported models via iOS Quick Look |

---

## 🏗️ Architecture

The application follows a **modular architecture** with five core modules:

### 1. LiDAR Scanning & Session Management
Configures and controls the AR session using `ARWorldTrackingConfiguration` with scene reconstruction enabled. Validates LiDAR hardware support, manages session lifecycle (start/pause/stop/resume), and monitors tracking quality.

### 2. Mesh Construction & Processing
The core reconstruction engine. Processes incoming `ARMeshAnchor` updates from ARKit, builds the cumulative 3D mesh, merges overlapping anchors, and performs post-processing (Laplacian smoothing, hole-filling, decimation).

### 3. Visualization & Interaction Module
Renders the live mesh using **SceneKit** within `ARSCNView`. Supports color-coded surface classification, collision detection with virtual objects, real-time occlusion, and user gestures (tap for measurements, place markers).

### 4. User Interface Module
Built with **SwiftUI**. Displays Start/Stop/Save controls, scanning progress indicators, tracking quality feedback, and error messages. Communicates with all other modules through a shared `ScannerViewModel`.

### 5. Data Export & Storage Module
Converts mesh data using **Model I/O** and exports to USDZ/OBJ formats. Manages file storage in the iOS Documents directory and handles file sharing via `UIActivityViewController` (AirDrop, Files app, etc.).

---

## 🔬 Algorithms & Techniques

| Algorithm | Description |
|---|---|
| **Visual-Inertial Odometry (VIO)** | ARKit's SLAM system for 6-DoF device tracking, preventing mesh drift |
| **LiDAR Depth Sensing** | Conceptually similar to Poisson surface reconstruction / KinectFusion TSDF |
| **ARMeshGeometry Conversion** | Transforms ARKit mesh buffers → SceneKit geometry → Model I/O assets |
| **Surface Classification (ML)** | On-device neural network classifies triangles as wall/floor/ceiling/table |
| **People Occlusion** | Deep learning segmentation masks humans out of the scan in real time |
| **Laplacian Smoothing** | Post-processing to smooth raw mesh noise from sensor data |
| **Grand Central Dispatch (GCD)** | Async mesh processing to keep the UI thread responsive at 60 FPS |

---

## 🛠️ Tech Stack

### iOS / Apple Frameworks

| Framework | Purpose |
|---|---|
| **Swift** | Primary programming language |
| **SwiftUI** | Declarative UI layer |
| **ARKit** | AR session, LiDAR depth sensing, mesh anchors, tracking |
| **RealityKit** | AR rendering pipeline |
| **Metal / MetalKit** | GPU-accelerated mesh rendering and ML inference |
| **SceneKit** | 3D scene graph, mesh visualization, physics |
| **Model I/O** | 3D asset management and file export (OBJ, USDZ, PLY, STL) |
| **AVFoundation** | Camera capture (LiDAR + RGB) |
| **SwiftData** | On-device data persistence |
| **CryptoKit** | Secure encryption for exported model files |
| **UIKit** | File sharing via `UIActivityViewController` |
| **QuickLook** | In-app 3D model preview |

### Supporting Tools

| Tool | Purpose |
|---|---|
| **Python + Open3D** | Backend 3D data processing and mesh analysis |
| **OpenCV / NumPy** | Image processing and numerical operations |
| **PyTorch / TensorFlow** | ML model support for reconstruction algorithms |
| **Hugging Face Transformers** | AI integrations |
| **Flask / FastAPI + Gradio** | Backend API and demo interfaces |
| **Blender** | Post-processing, texturing, and mesh refinement |
| **Figma** | UI/UX design and prototyping |
| **Xcode** | IDE for Swift development and deployment |
| **GitHub / Git** | Version control and collaboration |

---

## 📋 Requirements

### Hardware

| Requirement | Detail |
|---|---|
| **iPhone** | iPhone 12 Pro or later (LiDAR sensor required) |
| **iPad** | iPad Pro 2020 or later |
| **Mac** | Apple MacBook with Xcode for development |

### Software

| Requirement | Version |
|---|---|
| iOS | 16.0+ |
| Xcode | 14.0+ |
| Swift | 5.9+ |
| macOS | Ventura 13.0+ (for development) |

---

## 🚀 Getting Started

### Prerequisites

- Mac with **Xcode 14+** installed
- iPhone Pro or iPad Pro with LiDAR sensor
- Apple Developer account (for device deployment)

### Setup

```bash
# 1. Clone the repository
git clone https://github.com/adnan-ansari/lidar-3d-reconstruction.git
cd lidar-3d-reconstruction

# 2. Open the project in Xcode
open LiDAR3DReconstruction.xcodeproj

# 3. Connect your iPhone Pro or iPad Pro
# LiDAR does NOT work on the iOS Simulator

# 4. Set your development team
# Xcode > Project Settings > Signing & Capabilities > Team

# 5. Build and run
# Press Cmd+R or click the Run button
```

> **Important:** A physical **iPhone 12 Pro or later** (or iPad Pro 2020+) is required. The LiDAR scanner is not available in the iOS Simulator.

---

## 📱 App Flow

```
App Launch → Splash Screen → Auth Check
     ↓
Dashboard  (role-based navigation)
     ↓
Scanning Workspace → Start Scan → Live AR Mesh Preview
     ↓
Stop Scan → Post-Processing (smoothing, classification)
     ↓
Point Cloud View  →  Mesh Creation View
     ↓
Model Export View → Select Format (OBJ / PLY / STL / USDZ)
     ↓
Quick Look Preview → Share via AirDrop / Files App
```

### User Roles & Access

| Role | Features Available |
|---|---|
| **Admin** | Scanning, Point Cloud, Model Export, User Management |
| **Professional** | Scanning, AR Learning, Analytics, Point Cloud, Model Export |
| **Teacher** | AR Learning, Analytics, Renewable Energy, Reports |
| **Student** | AR Learning, Analytics, Renewable Energy, Reports |
| **Demo** | Scanning, Point Cloud, Model Export, User Management |

---

## 📤 Export Formats

| Format | Description | Compatible With |
|---|---|---|
| **USDZ** | Apple Universal Scene Description (default) | Quick Look, Reality Composer, Xcode |
| **OBJ** | Wavefront 3D object format | Blender, Maya, 3ds Max, Cinema 4D |
| **PLY** | Stanford Polygon File Format | MeshLab, CloudCompare, Open3D |
| **STL** | Stereolithography format | 3D printing software, CAD tools |

---

## 📁 Project Structure

```
LiDAR3DReconstruction/
├── App/
│   ├── DashboardView.swift           ← Role-based main dashboard
│   ├── ScanningWorkspaceView.swift   ← Live AR scanning interface
│   ├── MeshCreationView.swift        ← Mesh controls and debug tab
│   ├── PointCloudView.swift          ← Point cloud scanning and preview
│   └── ModelExportView.swift         ← Format selection and export workflow
│
├── ViewModels/
│   ├── ScannerViewModel.swift        ← Core scanning state and logic
│   └── AuthViewModel.swift           ← Auth and user session management
│
├── Modules/
│   ├── LiDARScanManager.swift        ← AR session config and lifecycle
│   ├── MeshProcessor.swift           ← ARMeshAnchor processing and smoothing
│   ├── VisualizationModule.swift     ← SceneKit rendering and interaction
│   └── ExportModule.swift            ← Model I/O export and file sharing
│
├── Models/
│   ├── UserModel.swift               ← User struct and UserRole enum
│   └── SettingsManager.swift         ← Theme and notification preferences
│
└── Resources/
    ├── Assets.xcassets
    └── Info.plist
```

---

## ⚠️ Known Limitations

- **LiDAR range:** Effective depth sensing up to ~5 meters
- **Texture export:** Exported meshes are geometry-only (no texture baking in current version)
- **Large environments:** Tracking drift may occur in spaces larger than ~10 meters
- **iOS only:** Android is not supported — requires Apple LiDAR hardware and ARKit
- **Featureless surfaces:** Blank white walls may cause minor tracking instability
- **Memory:** Meshes with 200k+ polygons may impact performance on older devices

---

## 🔮 Future Improvements

- Texture baking — project RGB camera frames onto exported mesh surfaces
- Multi-session scanning — merge scans from multiple separate sessions
- Optional cloud sync — backup and cross-device sharing of 3D models
- Android / ARCore support for broader hardware reach
- User-controlled mesh decimation quality settings
- Real-time multi-user collaborative scanning

---

## 🔒 Privacy

All scanning, mesh processing, and model storage happens **entirely on-device**. No video, depth data, or personal information is ever transmitted to any external server. The app complies with Apple's Human Interface Guidelines and on-device privacy requirements.

---

## 📄 License

This project is open-source. Third-party libraries including Open3D are licensed under Apache 2.0. See individual library documentation for full license terms.

---

## 👤 Author

**Adnan Ansari**  
Capstone Individual Project — Group 28  
University ID: 22013278 / 03642477  
Submitted: Monday, March 26, 2025

---

> Built entirely on Apple's ecosystem — Swift, ARKit, Metal, and SwiftUI. No cloud. No external dependencies. Just your iPhone and the real world.
