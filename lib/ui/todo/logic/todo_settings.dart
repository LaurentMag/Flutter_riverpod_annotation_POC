class TodoSettings {
  static const int animationDurationTopCard = 100;
  static const int animationDurationBottomCard = 100;

  static const double maxVelocityAllowed = 100;
  static const double dragMoveSpeedMultiplier = 0.5;

  static const double toDoCardHeight = 100;
  static const double toDoCardFontSize = 14;

  static const double iconButtonWidth = 80;

  // Following values are going to be set at to_do_Item build =============================

  /// The width of the toDo card that will be used to calculate the translation limits
  static const double maxwRightTranslCardWidthPct = 0.3;

  /// The right translation limit for the toDo card, where the translation will be stopped
  static double rightTranslationLimit = 0;

  /// The width of the toDo card that will be used to calculate the translation limits
  static const double maxLeftTranslCardWidthPct = 0.8;

  /// The left translation limit for the toDo card, where the translation will be stopped
  static double leftTranslationLimit = 0;

  /// The width of the toDo card that will be used to calculate the threadhold distance for deletion
  static const double deleteThresholdCardWidthPct = 0.75;

  /// The distance threshold for the toDo card to be deleted while translating the card with a drag gesture
  static double deleteThresholdDistance = 0;
}
