/// Api config
String FirstPostDocId_config = 'idanbit80@gmail.com[#f8926]';

// Demo
// const kStreamApiKey = 'wr4g7gb2388g';

/// App config (cp)
// int cpAgeFilter = 3; // +-3, so 17 will meet 14 - 20.

//~ Design config:
// BottomNavigation: true = make main BOLD, false = More logic Ui
bool boldPrimaryDesignConfig = false;

/// Dev (debug)
bool clearHiveBoxes = false; // (Clear cache)
// bool showDebugPrints = false && kDebugMode;

// ? CTRL + F: Outside Lib folder:
// ? var homeCooldown = 2 * 60;


// How Hive should works:
// 1. .add every item to his box (PostsBox, ChatsBox, Chat#123_MessagesBox)
// 2. Now every box have postsBox.values of HiveModels
// 3. Change it to List of Models
// 4. On Feed already works good Because no Likes or dynamic data (No requests of updates needed)
// 4. On Chats its not works well because