# minipong

Приложение для ведения счета настольного тенниса.

## Возможности

- Добавление и выбор игроков
- Ведение счета для двух игроков
- Сохранение партий
- Управление режимом смены подачи (2 или 5 ходов)
- Быстрое добавление голов с помощью кнопок и горячих клавиш (Ctrl/Space/Enter)
- История голов и партий

## Установка и запуск из монорепозитория

1. Установите flutter:
   ```bash
   sudo apt-get update
   sudo apt-get install curl git unzip xz-utils zip libglu1-mesa
   git clone https://github.com/flutter/flutter.git -b stable ~/flutter
   echo 'export PATH="$PATH:$HOME/flutter/bin"' >> ~/.zshrc
   flutter --version
   echo 'export PATH="$PATH":"$HOME/.pub-cache/bin"' >> ~/.zshrc
   dart pub global activate protoc_plugin
   ```

1. Установите [pnpm](https://pnpm.io/):
   ```bash
   npm install -g pnpm
   ```
2. Установите зависимости для всех пакетов:
   ```bash
   pnpm install
   ```
3. Для запуска backend-сервисов используйте:
   ```bash
   pnpm run dev -F services/auth
   pnpm run dev -F services/engine
   pnpm run dev -F services/gateway
   pnpm run dev -F services/profile
   ```
   Или запустите все сервисы через Docker Compose:
   ```bash
   docker-compose up --build
   ```
4. Для запуска фронтенда (Flutter):
   ```bash
   cd front
   flutter pub get
   flutter run
   
   adb devices   
   ```
   Скачай именно Command-line Tools (CLI)

git clone https://github.com/flutter/flutter.git -b stable ~/flutter
echo 'export PATH=$PATH:$HOME/flutter/bin' >> ~/.zshrc



mkdir -p ~/Android/Sdk/platform-tools
mkdir -p ~/Android/Sdk/build-tools
mkdir -p ~/Android/Sdk/ndk

mkdir -p ~/Android/Sdk/cmdline-tools
cd ~/Android/Sdk/cmdline-tools
curl -o tools.zip https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
unzip tools.zip -d latest
rm tools.zip


Пропиши переменные окружения  
В ~/.zshrc добавь:

bash
echo 'export ANDROID_HOME=$HOME/Android/Sdk' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.zshrc

source ~/.zshrc

sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0" "ndk;28.2.13676358"                                                                              [25/12/20| 4:16PM]
yes | sdkmanager --licenses

flutter config --android-sdk $ANDROID_HOME

sdkmanager "platforms;android-36" "build-tools;28.0.3"

sudo apt-get install -y clang cmake ninja-build pkg-config
sudo apt-get install -y libgtk-3-dev mesa-utils
sudo apt-get install openjdk-17-jdk

flutter doctor --android-licenses
flutter doctor

npm install -g firebase-tools
