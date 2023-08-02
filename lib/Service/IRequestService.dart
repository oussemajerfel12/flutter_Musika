import '../Model/LoginStauts.dart';
import '../Model/SearchOptions.dart';
import '../Model/SearchResult.dart';
import '../Model/CheckAvailabilityOptions.dart';
import '../Model/CheckAvailabilityResult.dart';

abstract class IRequestService {
  Future<SearchResult> Search(SearchOptions options);
  Future<CheckAvailabilityResult> CheckAvailability(
      CheckAvailabilityOptions options);

  Future<LoginStatus> authentication(
      String userAccount, String password, Uri baseUrl,
      {Function(Exception)? error});
}
