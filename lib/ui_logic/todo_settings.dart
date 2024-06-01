const int animationDurationTopCard = 100;
const int animationDurationBottomCard = 100;

const double maxVelocityAllowed = 100;
const double dragMoveSpeedMultiplier = 0.5;

const double toDoCardHeight = 100;
const double toDoCardFontSize = 14;

const double iconButtonWidth = 80;

// Following values are going to be set at to_do_Item build =============================

/// The width of the toDo card that will be used to calculate the translation limits
const double maxwRightTranslCardWidthPct = 0.3;

/// The right translation limit for the toDo card, where the translation will be stopped
double rightTranslationLimit = 0;

/// The width of the toDo card that will be used to calculate the translation limits
const double maxLeftTranslCardWidthPct = 0.8;

/// The left translation limit for the toDo card, where the translation will be stopped
double leftTranslationLimit = 0;

/// The width of the toDo card that will be used to calculate the threadhold distance for deletion
const double deleteThresholdCardWidthPct = 0.75;

/// The distance threshold for the toDo card to be deleted while translating the card with a drag gesture
double deleteThresholdDistance = 0;
