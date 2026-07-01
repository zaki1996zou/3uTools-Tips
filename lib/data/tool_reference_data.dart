/// Reference data for built-in utility tools.
abstract final class ToolReferenceData {
  static const iosVersions = [
    ('iOS 18.5', 'Latest security update', 'May 2025', true),
    ('iOS 18.4', 'Feature update', 'Apr 2025', true),
    ('iOS 18.3', 'Security update', 'Jan 2025', false),
    ('iOS 18.2', 'Feature update', 'Dec 2024', false),
    ('iOS 18.1', 'Feature update', 'Oct 2024', false),
    ('iOS 18.0', 'Major release', 'Sep 2024', false),
    ('iOS 17.7', 'Final iOS 17 update', 'Sep 2024', false),
  ];

  static const devices = [
    ('iPhone 16 Pro Max', 'iOS 18+'),
    ('iPhone 16 Pro', 'iOS 18+'),
    ('iPhone 16 Plus', 'iOS 18+'),
    ('iPhone 16', 'iOS 18+'),
    ('iPhone 15 Pro Max', 'iOS 17+'),
    ('iPhone 15 Pro', 'iOS 17+'),
    ('iPhone 15 Plus', 'iOS 17+'),
    ('iPhone 15', 'iOS 17+'),
    ('iPhone 14 Pro Max', 'iOS 16+'),
    ('iPhone 14 Pro', 'iOS 16+'),
    ('iPhone 14 Plus', 'iOS 16+'),
    ('iPhone 14', 'iOS 16+'),
    ('iPhone 13 series', 'iOS 15+'),
    ('iPhone 12 series', 'iOS 14+'),
    ('iPhone 11 series', 'iOS 13+'),
    ('iPhone SE (3rd gen)', 'iOS 15+'),
    ('iPhone SE (2nd gen)', 'iOS 13+'),
    ('iPhone XR / XS', 'iOS 12+'),
  ];

  static const errorCodes = [
    ('-1', 'Unknown error', 'Restart your desktop tool and computer. Try a different USB cable and port.'),
    ('1', 'Device not found', 'Ensure iPhone is unlocked, trusted, and connected via a data-capable USB cable.'),
    ('2', 'Firmware download failed', 'Check your internet connection and try downloading the IPSW again.'),
    ('6', 'Update failed', 'Put device in recovery mode and flash the latest signed firmware.'),
    ('9', 'Verification failed', 'The IPSW file may be corrupt. Re-download the firmware file.'),
    ('10', 'Low battery', 'Charge your iPhone to at least 50% before flashing or restoring.'),
    ('11', 'Corrupt firmware', 'Download a fresh IPSW from ipsw.me or your desktop tool.'),
    ('13', 'Device disconnected', 'Keep the cable connected. Disable auto-lock during the operation.'),
    ('14', 'USB communication error', 'Try another USB port. Avoid USB hubs. Reinstall Apple drivers on Windows.'),
    ('17', 'Signature verification failed', 'Apple may have stopped signing this iOS version. Use a currently signed IPSW.'),
    ('20', 'Recovery mode failed', 'Follow the DFU/Recovery guide for your specific iPhone model.'),
    ('21', 'Custom firmware error', 'Only use official Apple IPSW files for standard restores.'),
    ('26', 'NAND error', 'Storage issue detected. A full restore in recovery mode may be required.'),
    ('27', 'iTunes sync error', 'Disable iTunes auto-sync and close iTunes before using desktop tools.'),
    ('34', 'Disk full', 'Free up space on your computer hard drive before backup or restore.'),
    ('40', 'Backup password required', 'Enter your encrypted backup password or disable backup encryption in iTunes.'),
    ('47', 'Apple server error', 'Apple servers may be busy. Wait and try again later.'),
    ('48', 'SHSH save failed', 'Ensure device is connected and on a signed iOS version.'),
    ('50', 'File permission error', 'Run your desktop tool as administrator (Windows) or check folder permissions.'),
    ('53', 'Device in wrong mode', 'Put the device in normal, recovery, or DFU mode as required.'),
  ];

  static const dfuSteps = [
    (
      'Connect to Computer',
      'Plug your iPhone into your Mac or PC with a USB cable. Open your desktop iPhone utility.',
    ),
    (
      'Press Volume Up',
      'Quickly press and release the Volume Up button.',
    ),
    (
      'Press Volume Down',
      'Quickly press and release the Volume Down button.',
    ),
    (
      'Hold Side Button',
      'Press and hold the Side button for 10 seconds until the screen goes black.',
    ),
    (
      'Add Volume Down',
      'While holding Side, also hold Volume Down for 5 seconds, then release Side but keep holding Volume Down for 10 more seconds.',
    ),
    (
      'Screen Stays Black',
      'If successful, the screen remains black but your desktop tool detects DFU mode. You can now flash firmware.',
    ),
  ];

  static const backupChecklist = [
    'iPhone is connected and recognized by your desktop tool',
    'At least 10 GB free space on your computer',
    'iPhone is unlocked and "Trust This Computer" is accepted',
    'iTunes / Finder is not syncing in the background',
    'Backup encryption password is noted (if enabled)',
    'Photos and messages are included in backup scope',
    'Previous backup date is visible in your desktop tool',
    'Backup completed without errors',
  ];
}
