# codermate_play

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


### Hosting the web using ngrok



- In your terminal, inside the project folder:

`flutter build web`

```bash
cd build/web
python3 -m http.server 8000
```

Then in a new terminal tab:

`~/ngrok http 8000`