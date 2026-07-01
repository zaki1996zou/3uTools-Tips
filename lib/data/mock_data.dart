import 'package:flutter/material.dart';

import '../models/featured_guide.dart';
import '../models/news_article.dart';
import '../models/tool_item.dart';
import '../models/tutorial.dart';
import '../theme/app_colors.dart';

abstract final class MockData {
  static const homeCategories = [
    'All',
    'Flash',
    'Backup',
    'Ringtones',
    'Wallpaper',
  ];

  static const tutorialDifficultyFilters = [
    'All',
    'Beginner',
    'Advanced',
    'Fixes',
  ];

  static const tutorialCategoryFilters = [
    'All',
    'Flash',
    'Backup',
    'Restore',
    'Ringtones',
    'Wallpapers',
  ];

  static const newsCategories = [
    'All',
    'Resources',
    'iOS Updates',
    'Firmware',
    'iPhone',
    'Tutorials',
  ];

  static const featuredGuides = [
    FeaturedGuide(
      id: 'fg1',
      title: 'Backup Your iPhone in 1 Click',
      tutorialId: 't3',
    ),
    FeaturedGuide(
      id: 'fg2',
      title: 'Fix iPhone Stuck on Apple Logo',
      tutorialId: 't6',
    ),
    FeaturedGuide(
      id: 'fg3',
      title: 'Create Custom Ringtones Easily',
      tutorialId: 't5',
    ),
  ];

  static const quickToolsHome = [
    ('Flash iOS', Icons.bolt_rounded, AppColors.flashTint, AppColors.flashIcon),
    ('Backup Guide', Icons.cloud_upload_rounded, AppColors.backupTint, AppColors.backupIcon),
    ('Custom Ringtone', Icons.music_note_rounded, AppColors.ringtoneTint, AppColors.ringtoneIcon),
    ('Fix Errors', Icons.build_rounded, AppColors.fixTint, AppColors.fixIcon),
  ];

  static final tools = [
    ToolItem(
      id: 'tool1',
      title: 'iOS Version Checker',
      description: 'Check the latest iOS version available for your device.',
      icon: Icons.phone_iphone_rounded,
      iconBg: AppColors.backupTint,
      accent: AppColors.backupIcon,
    ),
    ToolItem(
      id: 'tool2',
      title: 'iPhone Compatibility',
      description: 'See if your iPhone model supports the latest iOS.',
      icon: Icons.smartphone_rounded,
      iconBg: AppColors.primaryTint,
      accent: AppColors.primary,
    ),
    ToolItem(
      id: 'tool3',
      title: 'DFU Mode Guide',
      description: 'Step-by-step guide to enter DFU recovery mode.',
      icon: Icons.refresh_rounded,
      iconBg: AppColors.flashTint,
      accent: AppColors.flashIcon,
    ),
    ToolItem(
      id: 'tool4',
      title: 'Error Code Lookup',
      description: 'Look up common iTunes and desktop utility error codes.',
      icon: Icons.error_outline_rounded,
      iconBg: AppColors.ringtoneTint,
      accent: AppColors.ringtoneIcon,
    ),
    ToolItem(
      id: 'tool5',
      title: 'Firmware Finder',
      description: 'Find signed IPSW firmware for your device.',
      icon: Icons.search_rounded,
      iconBg: AppColors.secondaryTint,
      accent: AppColors.primary,
    ),
    ToolItem(
      id: 'tool6',
      title: 'Backup Checker',
      description: 'Verify your iPhone backup is complete and valid.',
      icon: Icons.checklist_rounded,
      iconBg: AppColors.beginnerBg,
      accent: AppColors.beginner,
    ),
  ];

  static final tutorials = [
    Tutorial(
      id: 't1',
      title: 'Install Desktop iPhone Software',
      category: 'Install',
      difficulty: TutorialDifficulty.beginner,
      durationMinutes: 3,
      rating: 4.8,
      icon: Icons.download,
      subtitle: 'Get started with iPhone management software on Windows or Mac.',
      steps: const [
        TutorialStep(
          title: 'Download the Software',
          description: 'Download a trusted desktop iPhone utility from the developer’s official website.',
        ),
        TutorialStep(
          title: 'Install on Your Computer',
          description: 'Run the installer and follow the on-screen setup wizard.',
        ),
        TutorialStep(
          title: 'Connect Your iPhone',
          description: 'Plug in your device via USB and tap Trust on your iPhone.',
        ),
      ],
      proTips: const [
        'Only download desktop tools from official developer websites.',
        'Disable antivirus temporarily if the installer is blocked.',
      ],
    ),
    Tutorial(
      id: 't2',
      title: 'How to Flash iOS from a PC',
      category: 'Flash',
      difficulty: TutorialDifficulty.advanced,
      durationMinutes: 8,
      rating: 4.6,
      icon: Icons.bolt,
      subtitle: 'Flash or restore iOS firmware using desktop software.',
      steps: const [
        TutorialStep(
          title: 'Open Flash / Restore',
          description: 'Connect your iPhone and open the flash or firmware section in your desktop tool.',
        ),
        TutorialStep(
          title: 'Select Firmware',
          description: 'Choose the IPSW file or download the latest signed version.',
        ),
        TutorialStep(
          title: 'Start Flashing',
          description: 'Start the flash and keep your device connected until complete.',
        ),
      ],
      proTips: const [
        'Back up your data before flashing iOS.',
        'Ensure your battery is above 50% before starting.',
      ],
    ),
    Tutorial(
      id: 't3',
      title: 'How to Backup iPhone from a PC',
      category: 'Backup',
      difficulty: TutorialDifficulty.beginner,
      durationMinutes: 5,
      rating: 4.9,
      icon: Icons.cloud,
      subtitle: 'Create a full backup of your iPhone using desktop software.',
      steps: const [
        TutorialStep(
          title: 'Connect Device',
          description: 'Plug your iPhone into the computer running your desktop utility.',
        ),
        TutorialStep(
          title: 'Open Backup Section',
          description: 'Navigate to the backup or restore section in your desktop tool.',
        ),
        TutorialStep(
          title: 'Start Backup',
          description: 'Select full backup and wait for the process to finish.',
        ),
      ],
      proTips: const [
        'Full backups include photos, messages, and app data.',
        'Store backups on an external drive for extra safety.',
      ],
    ),
    Tutorial(
      id: 't4',
      title: 'How to Restore iPhone Backup',
      category: 'Restore',
      difficulty: TutorialDifficulty.intermediate,
      durationMinutes: 6,
      rating: 4.4,
      icon: Icons.history,
      subtitle: 'Restore your iPhone from a previous desktop backup.',
      steps: const [
        TutorialStep(
          title: 'Select Backup File',
          description: 'Open Backup/Restore and locate your saved backup.',
        ),
        TutorialStep(
          title: 'Choose Restore',
          description: 'Pick the data categories you want to restore.',
        ),
        TutorialStep(
          title: 'Confirm Restore',
          description: 'Click Restore and keep the device connected.',
        ),
      ],
      proTips: const [
        'Restoring will overwrite current data on your device.',
      ],
    ),
    Tutorial(
      id: 't5',
      title: 'How to Make Custom Ringtones',
      category: 'Ringtones',
      difficulty: TutorialDifficulty.beginner,
      durationMinutes: 4,
      rating: 4.5,
      icon: Icons.music_note,
      subtitle: 'Create and transfer custom ringtones to your iPhone.',
      steps: const [
        TutorialStep(
          title: 'Open Ringtone Maker',
          description: 'Go to the Toolbox section and select Ringtone Maker.',
        ),
        TutorialStep(
          title: 'Import Audio',
          description: 'Choose an MP3 or other audio file from your computer.',
        ),
        TutorialStep(
          title: 'Transfer to iPhone',
          description: 'Trim the clip and click Import to Device.',
        ),
      ],
      proTips: const [
        'Ringtones must be 30 seconds or shorter for iOS.',
      ],
    ),
    Tutorial(
      id: 't6',
      title: 'How to Save SHSH Blobs',
      category: 'SHSH',
      difficulty: TutorialDifficulty.advanced,
      durationMinutes: 6,
      rating: 4.1,
      icon: Icons.shield_outlined,
      subtitle: 'Save SHSH blobs for future iOS downgrades.',
      steps: const [
        TutorialStep(
          title: 'Go to Flash Tab',
          description: "Connect your iPhone and navigate to the 'Flash & JB' tab.",
        ),
        TutorialStep(
          title: 'Find SHSH Section',
          description: "Look for the 'SHSH' or 'Save SHSH' option.",
        ),
        TutorialStep(
          title: 'Save Current Blobs',
          description: "Click 'Save SHSH' to save the signing tickets for your currently installed iOS version.",
        ),
      ],
      proTips: const [
        'SHSH blobs are unique digital signatures that Apple uses to verify iOS installations.',
        'Saving SHSH blobs allows you to potentially downgrade to that iOS version in the future, even after Apple stops signing it.',
      ],
    ),
    Tutorial(
      id: 't7',
      title: 'Fix iPhone Stuck on Apple Logo',
      category: 'Fixes',
      difficulty: TutorialDifficulty.intermediate,
      durationMinutes: 7,
      rating: 4.6,
      icon: Icons.phone_iphone,
      subtitle: 'Recover an iPhone stuck on the Apple logo boot loop.',
      steps: const [
        TutorialStep(
          title: 'Enter Recovery Mode',
          description: 'Force restart and connect to your desktop tool in recovery mode.',
        ),
        TutorialStep(
          title: 'Flash Latest iOS',
          description: 'Download and flash the latest signed firmware.',
        ),
        TutorialStep(
          title: 'Restore from Backup',
          description: 'After flashing, restore your data from a backup.',
        ),
      ],
      proTips: const [
        'Try a force restart before flashing firmware.',
      ],
    ),
    Tutorial(
      id: 't8',
      title: 'Fix iTunes Not Recognizing iPhone',
      category: 'Fixes',
      difficulty: TutorialDifficulty.intermediate,
      durationMinutes: 5,
      rating: 4.3,
      icon: Icons.cable,
      subtitle: 'Troubleshoot USB connection issues with iTunes and desktop tools.',
      steps: const [
        TutorialStep(
          title: 'Check Cable & Port',
          description: 'Use an original Apple cable and try a different USB port.',
        ),
        TutorialStep(
          title: 'Trust This Computer',
          description: 'Unlock your iPhone and tap Trust when prompted.',
        ),
        TutorialStep(
          title: 'Reinstall Drivers',
          description: 'Reinstall Apple Mobile Device drivers on Windows.',
        ),
      ],
      proTips: const [
        'Disable VPN and firewall if connection still fails.',
      ],
    ),
  ];

  static final newsArticles = [
    NewsArticle(
      id: 'n1',
      category: 'Resources',
      title: 'Apple iPhone User Guide',
      summary:
          'Official Apple documentation for iPhone features, settings, updates, and troubleshooting.',
      date: 'Apple Support',
      views: 0,
      url: 'https://support.apple.com/guide/iphone/welcome/ios',
    ),
    NewsArticle(
      id: 'n2',
      category: 'iOS Updates',
      title: 'Check Your iPhone Software Version',
      summary:
          'Learn how to find your current iOS version on iPhone and whether an update is available '
          'through Settings → General → Software Update.',
      date: 'Apple Support',
      views: 0,
      url: 'https://support.apple.com/en-us/HT201685',
    ),
    NewsArticle(
      id: 'n3',
      category: 'Firmware',
      title: 'Find Signed IPSW Firmware for Your Device',
      summary:
          'Use IPSW.me to check which iOS versions Apple is currently signing for your iPhone model '
          'before attempting a restore or downgrade.',
      date: 'Community resource',
      views: 0,
      url: 'https://ipsw.me/',
    ),
    NewsArticle(
      id: 'n4',
      category: 'iPhone',
      title: 'Apple iPhone Repair & Service Options',
      summary:
          'If your device has hardware issues, visit Apple Support to check warranty status, '
          'schedule repairs, or find authorized service providers.',
      date: 'Apple Support',
      views: 0,
      url: 'https://support.apple.com/iphone/repair',
    ),
    NewsArticle(
      id: 'n5',
      category: 'Tutorials',
      title: 'Update iPhone Using a Computer',
      summary:
          'Apple explains how to update or restore iPhone using Finder on Mac or iTunes on Windows.',
      date: 'Apple Support',
      views: 0,
      url: 'https://support.apple.com/en-us/HT201252',
    ),
  ];

  static Tutorial? tutorialById(String id) {
    try {
      return tutorials.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }
}
