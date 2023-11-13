### Build
```
fvm flutter pub get
fvm flutter pub run build_runner build --delete-conflicting-outputs
fvm flutter run
```

### Deploy to web
1. Run `fvm flutter build web`
2. Copy files in a `build/web` folder to a `docs/` folder
3. Modify `href="/"` to `href="/localization-app/"` in a base tag within the `docs/index.html` file
4. Git push & automatically deployed for Github pages
