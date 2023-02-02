/// Encrypted storage
///
/// Set the encryption key before using the storage.
///
/// The encryption key must be 16 characters long.
///
/// This stroage use [SharedPreferences] to save the data synchronously.
///
/// This means that the data will be saved to the storage immediately, without waiting for the storage to finish saving the data.
///
abstract class StorageInstance {
  /// Set the encryption key for the storage
  ///
  /// This key will be used to encrypt the data before saving it to the storage
  ///
  /// This key must be set before using the storage
  ///
  /// If the key is not set, the data will be saved as plain text
  ///
  /// The key must be 16 characters long
  void setEncryptionKey(String key);

  /// Set a value to the storage
  ///
  /// [key] is the key to save the value to
  ///
  /// [value] is the value to save
  ///
  /// [value] must be a [Map<String, dynamic>]
  ///
  /// [value] will be encrypted before saving it to the storage
  ///
  /// If the encryption key is not set, the value will be saved as plain text
  void set(String key, Map<String, dynamic> value);

  /// Delete a value from the storage
  ///
  /// [key] is the key to delete the value from
  void delete(String key);

  /// Clear the storage
  void clear();

  /// Get a value from the storage
  ///
  /// [key] is the key to get the value from
  ///
  /// Returns a [Map<String, dynamic>] if the value exists
  ///
  /// Returns an empty [Map<String, dynamic>] if the value does not exist
  ///
  /// The value will be decrypted before returning it
  ///
  /// If the encryption key is not set, the value will be returned as plain text
  Map<String, dynamic>? get(String key);

  /// Get all values from the storage
  Map<String, dynamic>? getAll();

  /// Check if a key exists in the storage
  bool? containsKey(String key);

  /// Reload the storage
  Future<void> reload();
}
