cd "$(git rev-parse --show-toplevel)"
make clean generate # TODO this sjhould be another CI step
xcodebuild clean build test \
    -project LearningJourney/App/LearningJourney.xcodeproj \
    -scheme "LearningJourney - Debug" \
    -sdk iphonesimulator \
    -destination "platform=iOS Simulator,name=iPhone 8" \
    CODE_SIGNING_REQUIRED=NO