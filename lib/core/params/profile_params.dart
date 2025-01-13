import 'package:image_picker/image_picker.dart';

class UpdateUserParams {
  final String id;
  final XFile? avatar;
  final String? name;
  final String? phoneNumber;

  UpdateUserParams(
      {required this.id, this.avatar, this.name, this.phoneNumber});
}
