*Read this in other languages: [English](README.md), [中国](README-cn.md).*

# Visual Recognition with Core ML

[Watson Visual Recognition](https://www.ibm.com/watson/services/visual-recognition/) と [Core ML](https://developer.apple.com/machine-learning/) による画像の分類。
画像は Visual Recognition によって訓練済みの深層ニューラルネットワークを用いてオフラインで分類されます。


このプロジェクトには、2つのプロジェクトを含む `QuickstartWorkspace.xcworkspace` ワークスペースが含まれています:

- **Core ML Vision シンプル**: Visual Recognition を用いてローカルに画像を分類する。
- **Core ML Vision カスタム**: 特別な Visual Recognition モデルを訓練(トレーニング)し、より専門家された分類をおこなう。

## 始めるまえに

[Xcode 9][xcode_download] 以降と iOS 11.0 以降がインストールされていることを確認してください。これらのバージョンは Core ML をサポートするために必要です。

## ファイルの入手

リポジトリをローカルに複製するには、GitHub を使用するか、リポジトリの .zip ファイルをダウンロードしてファイルを展開します。

## Core ML Vision シンプルを実行する

組み込まれた Visual Recognition モデルが、一般的なオブジェクトを識別します。画像は [Core ML](https://developer.apple.com/documentation/coreml) フレームワークで分類されます。

1. Xcodeで `QuickstartWorkspace.xcworkspace` を開きます。
2. `Core ML Vision Simple` スキームを選択します。
3. シミュレータまたはデバイス上でアプリケーションを実行します。
4. カメラアイコンをクリックし、写真ライブラリから写真を選択して、画像を分類します。シミュレータにカスタム画像を追加するには、Finder からシミュレータ ウィンドウに画像をドラッグします。

**Tip**: このプロジェクトには、樹木や菌類を分類する Core ML モデルも含まれています。含まれている2つの Core ML モデルを切り替えるには、[ImageClassificationViewController](../master/Core%20ML%20Vision%20Simple/Core%20ML%20Vision%20Simple/ImageClassificationViewController.swift#L35-L39) で使用したいモデルのコメントを外します。

`ImageClassificationViewController` の [ソースコード](../master/Core%20ML%20Vision%20Simple/Core%20ML%20Vision%20Simple/ImageClassificationViewController.swift) 。

## Core ML Vision カスタムを実行する

このプロジェクトの第2部は、第1部のモデルを引き継いでおり、一般的な種類のケーブル (HDMI、USBなど) を識別するための Visual Recognition モデル (Classifier とも呼ばれます) を訓練します。
訓練済みのモデルをダウンロード、管理、実行するには、[Watson Swift SDK](https://github.com/watson-developer-cloud/swift-sdk) を使用してください。
Watson Swift SDK を使用することで、基礎となる Core ML フレームワークについて学ぶ必要はありません。

### Watson Studio で Visual Recognition をセットアップする

1.  [Watson Studio][watson_studio_visrec_tooling] にログインします。このリンクから、IBM Cloud アカウントを作成したり、Watson Studio にサインアップしたり、ログインすることができます。
2.  サインアップまたはログイン後、Watson Studio の Visual Recognition インスタンスの概要ページに移動します。

    **Tip**: 以降の手順で迷った場合は、ページの左上にある `IBM Watson` ロゴをクリックして、Watson Studio のホームページに移動します。 そこから "Watson services" の下で、サービスの横にある **Launch tool** ボタンをクリックすることで、Visual Recognition インスタンスにアクセスできます。

### モデルを訓練する

1.  Watson Studio の Visual Recognition 概要ページで、カスタムボックスの **Create Model** をクリックします。
2.  作成した Visual Recognition インスタンスにプロジェクトがまだ関連付けられていない場合は、プロジェクトが作成されます。 プロジェクトに `Custom Core ML` と名前を付けて **Create** をクリックします。

    **Tip**: もしストレージが定義されていなければ、**refresh** をクリックします。

3.  `Training Images` ディレクトリにあるサンプル画像の各 .zip ファイルを、ページの右側のデータペインにアップロードします。データペインの **Browse** ボタンをクリックして、モデルに `hdmi_male.zip` ファイルを追加します。また同様に `usb_male.zip`、` thunderbolt_male.zip`、`vga_male.zip` ファイルをモデルに追加してください。
4.  ファイルがアップロードされたら、各ファイルの隣にあるメニューから **Add to model** を選択し、それから **Train Model** をクリックします。

### モデル ID と API キーをコピーする

1.  Watson Studio のカスタム モデル概要ページで、(関連付けられているサービスの横にある) Visual Recognition のインスタンス名をクリックします。
2.  下にスクロールして、作成した **Custom Core ML** Classifier (Visual Recognition モデル) を見つけます。
3.  Classifier の **Model ID** をコピーします。
4.  Watson Studio の Visual Recognition インスタンス概要ページで、**Credentials** タブをクリックし、次に **View credentials** をクリックします。サービスの `api_key` か `apikey` をコピーしてください。

    **重要**: `api_key` によるインスタンス化は、2018年5月23日以前に作成された Visual Recognition サービスインスタンスでのみ機能します。5月22日以降に作成された Visual Recognition インスタンスは IAM (Identity and Access Management) を使用します。

### classifierId と apiKey をプロジェクトに追加する

1.  プロジェクトを XCode で開く。
2.  **Model ID** をコピーし、[ImageClassificationViewController](../master/Core%20ML%20Vision%20Custom/Core%20ML%20Vision%20Custom/ImageClassificationViewController.swift) ファイルの **classifierID** プロパティにペーストする。
3.  **api_key** もしくは **apikey** キーもコピーし、[ImageClassificationViewController](../master/Core%20ML%20Vision%20Custom/Core%20ML%20Vision%20Custom/ImageClassificationViewController.swift) ファイルの **api_key** もしくは **apikey** プロパティにペーストする。

### Watson Swift SDK をダウンロードする

Carthage 依存管理マネージャーを使用して、Watson Swift SDK をダウンロードしてビルドします。

1.  [Carthage](https://github.com/Carthage/Carthage#installing-carthage) をインストール。
2.  ターミナルを開いて、`Core ML Vision Custom` ディレクトリに移動。
3.  以下のコマンドを実行して、Watson Swift SDK をダウンロードし、ビルドする:

    ```bash
    carthage bootstrap --platform iOS
    ```

    **Tip:** SDK のアップデートを定期的にダウンロードして、このプロジェクトのアップデートと同期してください。

### カスタム モデルをテストする

1. `QuickstartWorkspace.xcworkspace` を Xcode で開く。
2. `Core ML Vision Custom` スキーマを選択。
3. シミュレータまたはデバイス上でアプリケーションを実行します。
4. カメラアイコンをクリックし、写真ライブラリから写真を選択して、画像を分類します。シミュレータにカスタム画像を追加するには、Finder からシミュレータ ウィンドウに画像をドラッグします。
5. 新しいバージョンの Visual Recognition モデルを、右下の更新ボタンで反映します。

    **Tip:** アプリを使用するには、Classifier (Visual Recognition モデル) のステータスが `Ready` である必要があります。Watson Studio の Visual Recognition インスタンス概要ページで、Classifier のステータスを確認します。

`ImageClassificationViewController` の [ソースコード](../master/Core%20ML%20Vision%20Custom/Core%20ML%20Vision%20Custom/ImageClassificationViewController.swift) 。

## 次はどうする

[Core ML Visual Recognition with Discovery][vizreq_with_discovery] プロジェクトを使用して、別の Watson サービスをカスタム プロジェクトに追加する。

## リソース

- [Watson Visual Recognition (画像認識)](https://www.ibm.com/watson/jp-ja/developercloud/visual-recognition.html)
- [Watson Visual Recognition Tool][vizreq_tooling]
- [Apple 機械学習](https://developer.apple.com/machine-learning/)
- [Core ML ドキュメント](https://developer.apple.com/documentation/coreml)
- [Watson Swift SDK](https://github.com/watson-developer-cloud/swift-sdk)
- [IBM Cloud](https://bluemix.net)

[vizreq_with_discovery]: https://github.com/watson-developer-cloud/visual-recognition-with-discovery-coreml/
[xcode_download]: https://developer.apple.com/xcode/downloads/
[vizreq_tooling]: https://dataplatform.ibm.com/registration/stepone?context=wdp&apps=watson_studio&target=watson_vision_combined
[watson_studio_visrec_tooling]: https://dataplatform.ibm.com/registration/stepone?target=watson_vision_combined&context=wdp&apps=watson_studio&cm_sp=WatsonPlatform-WatsonPlatform-_-OnPageNavCTA-IBMWatson_VisualRecognition-_-CoreMLGithub
