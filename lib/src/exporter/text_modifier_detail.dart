import 'package:gurps_dice/gurps_dice.dart';

import '../modifier_detail.dart';
import 'package:gurps_dart/gurps_dart.dart';

class TextModifierDetail extends ModifierDetail {
  String name;
  bool inherent;
  int value;
  int spellPoints;

  @override
  String get typicalText {
    return (detailText.length > 0)
        ? '${name}, ${detailText} (${spellPoints})'
        : '${name} (${spellPoints})';
  }

  @override
  String get detailText => '';

  @override
  String get summaryText => name;
}

class TextAfflictionDetail extends TextModifierDetail
    implements AfflictionDetail {
  String specialization;

  @override
  String get summaryText => '${name}, ${specialization}';

  @override
  String get detailText => specialization ?? '';
}

class TextAlteredTraitsDetail extends TextModifierDetail
    implements AlteredTraitsDetail {
  final List<TraitModifier> modifiers = [];

  @override
  int baseCost;

  @override
  int costPerLevel;

  @override
  bool hasLevels;

  @override
  int levels;

  @override
  String traitName;

  @override
  void addModifier(TraitModifier e) => modifiers.add(e);

  @override
  String get summaryText {
    String temp = '${name}, ${traitName}';
    if (modifiers.isNotEmpty) {
      temp += ' (${modifiers.map((e) => e.summaryText).join('; ')})';
    }
    return temp;
  }

  @override
  String get detailText {
    String temp = '${traitName}';
    if (hasLevels) {
      temp += ' ${levels}';
    }

    if (modifiers.isNotEmpty) {
      temp += ' (${modifiers.map((e) => e.typicalText).join('; ')})';
    }
    return temp;
  }
}

class TextAreaOfEffectDetail extends TextModifierDetail
    implements AreaOfEffectDetail {
  @override
  bool includes;

  @override
  int targets;

  @override
  String get detailText {
    List<String> components = [];
    components.add('${value} yards');
    if (targets > 0) {
      components
          .add('${includes ? 'Includes' : 'Excludes'} ${targets} targets');
    }
    return components.join(', ');
  }
}

class TextBestowsDetail extends TextModifierDetail implements BestowsDetail {
  String specialization;
  String range;

  @override
  String get summaryText => '${name}, ${specialization}';

  @override
  String get name => 'Bestows a ${value < 0 ? 'Penalty' : 'Bonus'}';

  @override
  String get detailText => '${toSignedString(value)} to ${specialization}';
}

class TextDamageDetail extends TextModifierDetail implements DamageDetail {
  DieRoll dieRoll;
  String type;
  bool direct;
  bool vampiric;
  bool explosive;

  final List<TraitModifier> modifiers = [];

  @override
  String get summaryText {
    String temp = '${name}, ${direct ? 'Direct' : 'Indirect'} ${type}';
    if (modifiers.isNotEmpty) {
      temp += ' (${modifiers.map((e) => e.name).join('; ')})';
    }
    return temp;
  }

  @override
  String get detailText {
    String temp = '${direct ? 'Direct' : 'Indirect'} ${type} ${dieRoll}';
    if (modifiers.isNotEmpty) {
      temp += ' (${modifiers.map((e) => "${e.typicalText}").join('; ')})';
    }
    return temp;
  }

  @override
  void addTraitModifier(TraitModifier e) {
    modifiers.add(e);
  }
}

class TextDurationDetail extends TextModifierDetail {
  @override
  String get detailText => GDuration.toFormattedString(value);
}

class TextRangeDetail extends TextModifierDetail {
  @override
  String get detailText => GDistance.toFormattedString(value);
}

class TextRangeDimensionalDetail extends TextModifierDetail {
  @override
  String get detailText => value == 1 ? '' : value.toString() + ' dimensions';
}

class TextRangeInformationalDetail extends TextModifierDetail {
  @override
  String get name => 'Range';

  @override
  String get detailText => GDistance.toFormattedString(value);
}

class TextRangeTimeDetail extends TextModifierDetail {
  @override
  String get detailText {
    if (value == 0) {
      return GDuration.toFormattedString(GDuration(hours: 2).inSeconds);
    } else {
      return GDuration.toFormattedString(GDuration(hours: value).inSeconds);
    }
  }
}

class TextRepairDetail extends TextModifierDetail implements RepairDetail {
  @override
  DieRoll dieRoll;

  @override
  String specialization;

  @override
  String get typicalText {
    return (detailText.length > 0)
        ? '${name} ${detailText} (${spellPoints})'
        : '${name} (${spellPoints})';
  }

  @override
  String get detailText =>
      '${specialization == null ? ' ' : '${specialization}'}, ${dieRoll}';
}

class TextSpeedDetail extends TextModifierDetail {
  @override
  String get detailText => '${GDistance.toFormattedString(value)}/second';
}

class TextSubjectWeightDetail extends TextModifierDetail {
  @override
  String get detailText => GWeight.toFormattedString(value);
}

class TextSummonedDetail extends TextModifierDetail {
  @override
  String get detailText => '${value}% of Static Point Total';
}
