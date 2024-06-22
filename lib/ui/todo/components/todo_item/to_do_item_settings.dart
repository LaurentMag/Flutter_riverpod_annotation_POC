const int animationDurationTopCard = 100;
const int animationDurationBottomCard = 100;

const double maxVelocityAllowed = 100;

/// create a limiter to the move speed detected
const double dragMoveSpeedMultiplier = 0.5;

const double toDoCardHeight = 100;
const double toDoCardFontSize = 14;

const double iconButtonWidth = 80;

/// The width of the toDo card that will be used to calculate the translation limits
const double maxRightTranslCardWidthPct = 0.3;

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

/// Distance that need to be reach to allow "to do completion toggle" using gesture only
const double completionThresholdDistance = 5;

/// X value that will determine the the distance that need to be reach
/// to have the translating card be moved to a value where the underneath button is going to be visible
const double leftButtonDisplayTreshold =
    iconButtonWidth * checkButtonVisibilityFactor;

/// X value that will determine the the distance that need to be reach
/// to have the translating card be moved to a value where the underneath buttons is going to be visible
const double rightButtonDisplayTreshold =
    iconButtonWidth * doubleButtonVisibilityFactor;

const double checkButtonVisibilityFactor = 0.6;
const double doubleButtonVisibilityFactor = 0.9;
