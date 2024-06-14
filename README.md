# localization-app
ACM MobiSys 2024 の Poster/Demo で展示した自己位置推定アプリ（Flutter）です。デモ展示ではFlaskサーバーとの通信を行い、PyTorchで作成した学習済みの深層学習モデルを動かしました。  

- モデル
  - https://github.com/sakusaku3939/YoloLSTM
- 論文URL
  - [Demo: Image-based Indoor Localization using Object Detection and LSTM](https://doi.org/10.1145/3643832.3661836)

| ホーム画面 | データセット収集画面 | 位置推定画面 |
| ---- | ---- | ---- |
| ![1](https://github.com/sakusaku3939/localization-app/assets/53967490/8147601b-605c-4389-9442-ce95858b3437) | ![2](https://github.com/sakusaku3939/localization-app/assets/53967490/ca150796-e99d-460d-af33-bf033603de29) | ![3](https://github.com/sakusaku3939/localization-app/assets/53967490/b67e87ea-e621-4dd9-946f-5ebc85f8fae8) |

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
