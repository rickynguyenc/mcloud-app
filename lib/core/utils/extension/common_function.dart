enum BoxStorage { inventory, resultinventory }

// get name off enum
extension BoxStorageExtension on BoxStorage {
  String get name {
    switch (this) {
      case BoxStorage.inventory:
        return 'inventorys';
      case BoxStorage.resultinventory:
        return 'resultinventory';
      default:
        return '';
    }
  }
}
