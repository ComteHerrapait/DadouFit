set -e

if [ -d flutter ]; then
  (cd flutter && git pull)
else
  git clone https://github.com/flutter/flutter.git
  (cd flutter && git fetch --tags && git switch stable)
fi

echo "FLUTTER IS INSTALLED"

flutter/bin/flutter doctor
flutter/bin/flutter clean
flutter/bin/flutter config --enable-web
flutter/bin/flutter pub get
flutter/bin/flutter precache --web

echo "FLUTTER IS SET UP"

flutter/bin/flutter build web --web-renderer html --base-href="/" --release
