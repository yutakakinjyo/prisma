#!/bin/bash
echo '######################################'
echo '#               Publish              #'
echo '#              - START -             #'
echo '######################################'

echo '---- Cloning repo into /tmp ----'
cd /tmp
git clone https://${GH_OAUTH_TOKEN}@github.com/${GH_USER_NAME}/${GH_PROJECT_NAME} gh-pages 2>&1
cd gh-pages

echo '---- Switch to gh-pages branch ----'
git checkout gh-pages

echo '---- Copy latest PDF build ----'
cp $RESULT_PDF_PATH ./${TRAVIS_BRANCH}-prisma.pdf

echo '---- Copy latest EPUB build ----'
cp $RESULT_EPUB_PATH ./${TRAVIS_BRANCH}-prisma.epub

echo '---- Copy latest Word build ----'
cp $RESULT_DOCX_PATH ./${TRAVIS_BRANCH}-prisma.docx

echo '---- Copy latest HTML build ----'
cp $RESULT_HTML_PATH ./index.html

echo '---- Set git settings ----'
git config --global user.name $GIT_AUTHOR_NAME
git config --global user.email $GIT_AUTHOR_EMAIL
git config --global push.default matching

echo '---- Add files, commit and push ----'
git add -A
git commit -m "Adding latest build of pdf,epub,docx and html to gh-pages"
git push https://${GH_OAUTH_TOKEN}@github.com/${GH_USER_NAME}/${GH_PROJECT_NAME} 2>&1

echo '######################################'
echo '#              Publish               #'
echo '#            - FINISHED -            #'
echo '######################################'
