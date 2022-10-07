import 'package:flutter/foundation.dart';

/// Api config
bool myUseSample = false;
bool myCleanConfig = false;
const kStreamApiKey = 'ah48ckptkjvm';

// Demo
// const kStreamApiKey = 'wr4g7gb2388g';
// const kStreamUserId = 'tom';
// const kStreamToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoidG9tIn0._HkDWmGM3ItRXTLn9-s7N_8XBew_DxHBBH9eDHjRtP4';

/// App config (cp)
int cpAgeFilter = 3; // +-3, so 17 will meet 14 - 20.
bool cpIsLoading = false; // setState to hide

//~ Design config:
// BottomNavigation: true = make main BOLD, false = More logic Ui
bool boldPrimaryDesignConfig = false;

/// Dev (debug)
bool showDebugPrints = true;
bool alwaysNewUserDebug = false && kDebugMode;

// ? CTRL + F: Outside Lib folder:
// ? var homeCooldown = 2 * 60;
// ? bool quickerSlowModeDebug = true; // true: x15 faster
