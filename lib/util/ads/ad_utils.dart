// google_mobile_ads import 'dart:async';
// google_mobile_ads import 'dart:io';

// google_mobile_ads import 'package:google_mobile_ads/google_mobile_ads.dart';

// google_mobile_ads enum AdType {
// google_mobile_ads   XP,
// google_mobile_ads   MONEY,
// google_mobile_ads }

// google_mobile_ads class AdUtils {
// google_mobile_ads   static const USE_PRODUCTION_IDS = true;

// google_mobile_ads   static const _PRODUCTION_IOS_XP_BONUS = "ca-app-pub-";
// google_mobile_ads   static const _PRODUCTION_IOS_MONEY_BONUS = "ca-app-pub-";

// google_mobile_ads   static const _PRODUCTION_ANDROID_XP_BONUS = "ca-app-pub-";
// google_mobile_ads   static const _PRODUCTION_ANDROID_MONEY_BONUS = "ca-app-pub-";

// google_mobile_ads   static const _TEST_ID = "ca-app-pub-3940256099942544/5224354917";

// google_mobile_ads   static String get xpBonusId {
// google_mobile_ads     if (USE_PRODUCTION_IDS) return Platform.isIOS ? _PRODUCTION_IOS_XP_BONUS : _PRODUCTION_ANDROID_XP_BONUS;
// google_mobile_ads     return _TEST_ID;
// google_mobile_ads   }

// google_mobile_ads   static String get moneyBonusId {
// google_mobile_ads     if (USE_PRODUCTION_IDS) return Platform.isIOS ? _PRODUCTION_IOS_MONEY_BONUS : _PRODUCTION_ANDROID_MONEY_BONUS;
// google_mobile_ads     return _TEST_ID;
// google_mobile_ads   }

// google_mobile_ads   static RewardedAd? getAdForType(type) {
// google_mobile_ads     switch (type) {
// google_mobile_ads       case AdType.XP:
// google_mobile_ads         return xpAd;
// google_mobile_ads       case AdType.MONEY:
// google_mobile_ads         return moneyAd;
// google_mobile_ads     }
// google_mobile_ads   }

// google_mobile_ads   static RewardedAd? xpAd;
// google_mobile_ads   static RewardedAd? moneyAd;

// google_mobile_ads   static Future<void> prepareAd(AdType type) {
// google_mobile_ads     final completer = Completer();
// google_mobile_ads     RewardedAd.load(
// google_mobile_ads       adUnitId: type == AdType.XP ? xpBonusId : moneyBonusId,
// google_mobile_ads       request: AdRequest(),
// google_mobile_ads       rewardedAdLoadCallback: RewardedAdLoadCallback(
// google_mobile_ads         onAdLoaded: (RewardedAd ad) {
// google_mobile_ads           switch (type) {
// google_mobile_ads             case AdType.XP:
// google_mobile_ads               xpAd = ad;
// google_mobile_ads               break;
// google_mobile_ads             case AdType.MONEY:
// google_mobile_ads               moneyAd = ad;
// google_mobile_ads               break;
// google_mobile_ads           }
// google_mobile_ads           completer.complete();
// google_mobile_ads         },
// google_mobile_ads         onAdFailedToLoad: (LoadAdError error) {
// google_mobile_ads           completer.completeError(error);
// google_mobile_ads           print('RewardedAd failed to load: $error');
// google_mobile_ads         },
// google_mobile_ads       ),
// google_mobile_ads     );
// google_mobile_ads     return completer.future;
// google_mobile_ads   }

// google_mobile_ads   static Future<bool> showAd(AdType type) async {
// google_mobile_ads     final completer = Completer<bool>();
// google_mobile_ads     var ad = getAdForType(type);
// google_mobile_ads     if (ad == null) await prepareAd(type);
// google_mobile_ads     ad = getAdForType(type);
// google_mobile_ads     if (ad == null) throw Exception('failed to load ad');
// google_mobile_ads     ad.fullScreenContentCallback = FullScreenContentCallback(
// google_mobile_ads       onAdShowedFullScreenContent: (RewardedAd ad) => print('$ad onAdShowedFullScreenContent.'),
// google_mobile_ads       onAdDismissedFullScreenContent: (RewardedAd ad) {
// google_mobile_ads         print('$ad onAdDismissedFullScreenContent.');
// google_mobile_ads         completer.complete(false);
// google_mobile_ads       },
// google_mobile_ads       onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
// google_mobile_ads         print('$ad onAdFailedToShowFullScreenContent: $error');
// google_mobile_ads         completer.complete(false);
// google_mobile_ads       },
// google_mobile_ads       onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
// google_mobile_ads     );
// google_mobile_ads     ad.show(onUserEarnedReward: (RewardedAd ad, RewardItem rewardItem) {
// google_mobile_ads       completer.complete(true);
// google_mobile_ads     });
// google_mobile_ads     final result = await completer.future;
// google_mobile_ads     ad.dispose();
// google_mobile_ads     prepareAd(type);
// google_mobile_ads     return result;
// google_mobile_ads   }
// google_mobile_ads }
