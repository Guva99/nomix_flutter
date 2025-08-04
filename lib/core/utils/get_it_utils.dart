
import 'package:logger/web.dart';
import 'package:nomix/core/database/data/repositories/hivey.dart';
import 'package:nomix/core/internal/sl.dart';


abstract class GetItUtils{
    static final hive = getIt.get<HiveApp>();

    static final logger = getIt.get<Logger>();


}