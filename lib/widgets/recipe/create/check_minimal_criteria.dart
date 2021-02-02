import 'package:provider/provider.dart';

import '../../../data/images.dart';
import '../../../data/ingredients.dart';
import '../../../data/instructions.dart';
import '../../../data/overview.dart';

checkMinimalCriteria(context) {
    Overview overview = Provider.of<Overview>(context, listen: true);
    Ingredients ingredients = Provider.of<Ingredients>(context, listen: true);
    Instructions steps = Provider.of<Instructions>(context, listen: true);
    Images images = Provider.of<Images>(context, listen: true);

    if (overview.title.length > 2 &&
        overview.time > 0 &&
        overview.portions > 0 &&
        ingredients.ingredientList.length > 0 &&
        steps.instructionList.length > 0 &&
        images.imageList.length > 0) {
      return true;
    } else {
      return false;
    }
  }