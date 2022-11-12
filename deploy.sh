#!/bin/sh

GIT=`which git`
REPO_DIR=${PWD}
WEB_DIR="/Users/khanhld/Development/coderpush/khanhld1910.github.io/codermate_test"


echo "Build Flutter web"
flutter build web --base-href "/codermate_test/"

echo "Remove old web"
rm -rf ${WEB_DIR}/*

echo "Copy new web"
cp -R ${REPO_DIR}/build/web/* ~/Development/coderpush/khanhld1910.github.io/codermate_test

echo "Push new web to GitHub"
cd "${WEB_DIR}" -e && git add . && git commit -m "Update" && git push

echo "Done!"
cd ${REPO_DIR}
