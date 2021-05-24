class APIPath {
  static String job(
    String uid,
    String jobID,
  ) =>
      '/users/$uid/jobs/$jobID';
  static String jobs(String uid) => 'users/$uid/jobs';
  static String entry(
    String uid,
    String entryId,
  ) =>
      'users/$uid/entries/$entryId';
  static String entries(
    String uid,
  ) =>
      'users/$uid/entries';

  static String listChildren(
    String uid,
  ) =>
      '/Users/$uid/children';

  static String givenChildrenLocation(
    String uid,
    String childName,
  ) =>
      '/Users/$uid/children/$childName/location';

  static String givenChildrenLatitude(
    String uid,
    String childName,
  ) =>
      '/Users/$uid/children/$childName/latitude';

  static String givenChildrenLongitude(
    String uid,
    String childName,
  ) =>
      '/Users/$uid/children/$childName';
}
