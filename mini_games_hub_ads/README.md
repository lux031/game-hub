Mini Games Hub with Ads
-----------------------

Included:
- Flutter app with 3 games:
  * Tic Tac Toe
  * Number Tap
  * Memory Match

Ads Integrated:
- Banner ads on Home Screen
- Interstitial and Rewarded Ad managers included (you can call them from games)

Setup:
1. Replace test adUnitIds in ad_helper.dart with your own AdMob IDs.
2. Run `flutter pub get` then `flutter run`.

Notes:
- Test IDs are currently used; use your own IDs for production.
- You can call InterstitialAdManager().show() when exiting games.
- You can call RewardedAdManager().show(() { /* reward logic */ }); for rewards.