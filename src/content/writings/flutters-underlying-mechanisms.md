---
title: Flutter's Underlying Mechanisms: A Closer Look
dek: Dart's JIT and AOT modes, Skia, and why Flutter paints its own pixels.
date: Archive
kind: Essay
---

Well after Facebook released their now ubiquitous cross-platform framework React Native in 2008, Google developed Flutter, an open-source framework with the ability to quickly build and iterate upon cross-platform apps from a single codebase. After years of cherry-picking the best design concepts from codebases across the internet, Google released Flutter in 2017. In this post I address the underlying details of Flutter’s runtime environment and broader engineering choices to evince why I believe Flutter will be an industry staple for iOS, Android, and Web apps 10 years from now.

## Flutter's Runtime Landscape

At the heart of Flutter's operational environment lies the Dart Virtual Machine (Dart VM). Dart, Flutter's programming language, operates its VM akin to Java. In debug mode, Flutter apps run Dart VM, reaping exceptional benefits like the hot reload feature. Flutter parts ways in production mode with the Dart VM, primarily due to its bulky nature and iOS's restrictions against JIT (Just-In-Time) compilation. In such cases, Flutter leans on Ahead-Of-Time (AOT) compilation to transform Dart code into native machine code tailored for efficient functionality on its targeted platform.

## Universal Compilation

Flutter's cross-platform expertise emanates from an amalgamation of its sophisticated architecture and Dart’s different compilation modes:

Skia Graphics Engine: Central to Flutter's operations, the Skia Graphics Engine is a rendering powerhouse. It takes the onus of painting pixels directly onto the display, circumventing the platform's native UI elements, by delivering one file that generates all elements on the screen.

Widgets Galore: In Flutter, everything depends on widgets. Instead of relying on native components, Flutter boasts several extensive libraries of widgets and maintains a vast package repository for open-source contributions by the community. Nested within one another to achieve compounding configurability, widgets can be merged and modified representing the building blocks of intricate UIs.

Dart's Dual Compilation: Dart is versatile, offering two primary compilation modes: JIT (Just-In-Time) Compilation: Allowing for more novel features like hot reload. AOT (Ahead-Of-Time) Compilation: Employed during production transmuting Dart’s code into native ARM or x86 machine code, ensuring swift launch times and optimal performance.

## Platform-specific Compilation

iOS and Android: For these mobile giants, Flutter resorts to AOT compilation to morph Dart code into native ARM or x86 machine code. The churned-out code coordinates with the platform via Flutter's embedding API, which interacts with the OS for chores like input reception and availing system services.

Web: Here, Flutter adopts a distinct approach. Instead of crafting machine code, Dart code undergoes transpilation to JavaScript. Flutter employs a blend of Canvas API and CSS to exhibit widgets on web browsers. As of now, Flutter’s web performance slightly lags behind JavaScript’s. However, Flutter is keenly venturing into incorporating WebAssembly for its web rendition. WebAssembly, adopted by all web browsers since 2019, permits the execution of binary code on the web, thus empowering developers to code in their language of choice (think 3d web rendering on an iPhone 6). As Flutter integrates this, it is poised to witness a surge in its performance, further solidifying its preeminence.

## The Challenge with Flutter's Web Delivery

The hitch in Flutter's armor concerns its web deployment. Since Flutter presents web pages as a canvas, it doesn't incorporate elements within the Document Object Model (DOM). This deviation poses SEO challenges, making it tougher for search engines to index Flutter-rendered websites than JavaScript ones. As the adoption of WASM becomes widespread for its efficiency, similar challenges will emerge for JavaScript sites, as WASM doesn't interact with the DOM. However, this is a concern that both the Flutter team and Google’s search team are actively addressing by developing indexing capabilities on WASM enabled websites.

## The Thought Process Behind Flutter

Dart's prowess in supporting JIT and AOT compilation perfectly complements Flutter's need for a brisk development cycle (via JIT) and top-tier production apps (via AOT). Flutter's audacious decision to sideline native UI components and paint directly using Skia ensures consistency in app appearance and functionality across platforms. Moreover, it empowers developers to have unparalleled control, paving the way for innovative designs that are more arduous with native components.

## Noteworthy Tidbits

Hot Reload: This was a game-changer during Flutter's debut. It empowers an effortless developer experience by infusing fresh source code into a live Dart VM, paving the way for swift modifications without restarting the application. Beyond Mobile & Web: Flutter's dexterity isn't confined to mobile and web platforms. Its versatile architecture has catalyzed explorations and innovations for desktop and embedded systems. Fuchsia & Flutter: Google's brainchild, the Fuchsia OS, has adopted Flutter as its main UI framework, underscoring Google's commitment to Flutter's further evolution.

## Future Prospects

Flutter's engineering genius lies in its blend of the Dart language with the Skia graphics engine. Augmented by well-thought-out decisions, it promises performance, uniformity, and developer-centric features for a fast development cycle at the cornerstone of the mercurial trends and intensive needs of the 21st century. Flutter's inception occurred when the tech world had already witnessed the likes of React and Next.js. This chronological advantage enabled the Flutter team to assimilate the gems from preceding languages while discarding the chaff. Given Flutter’s adaptive approach, combined with continuous enhancements like the WebAssembly integration, it wouldn't be a stretch to envision Flutter as the de facto choice for app development a decade from now.

[Flutter Website](https://flutter.dev/)

[Pub.dev Package Repository](https://pub.dev/)
